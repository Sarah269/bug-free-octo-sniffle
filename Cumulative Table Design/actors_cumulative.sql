-- Dimension Data Modeling
-- Create a table where a row lists an actors films up to a certain point in time, i.e. current_year
-- quality_class assigns a category rating to the actors performance in a year.  Determined by average ratings for movies made in the current year
-- is_active indicates whether an actor made a film that year
-- Populate table using a cumulative query

-- input table:  actor_films
-- output table: actors

 -- create an array of struct for film attributes

create type films as (
	year integer,
	film text,
	votes integer,
	rating real,
	filmid text
	);

-- create enum for actor's performance quality
--create type quality_class as enum ('star', 'good', 'average', 'bad')
-

create table actors (
	actorid text,
	actor text,
	current_year integer,
	films films[],
	quality_class quality_class,
	is_active boolean
	);

-- inital current year = 1969, year = 1970
-- Looking at the actors_films table:  min(year) = 1970, max(year) = 2021

-- Cumulative query to populate this table from 1970 to 1980
-- The query is run year by year

insert into actors 

-- Calculate the average film rating for the year for an actor
-- Actors can have multiple films in a year
with  actor_films_with_avgrating as (
     	select *, 
		avg(rating) over (partition by actorid, year order by actorid, year) as avg_rating
		from actor_films
		order by actorid, year
)
 
-- yesterday.  prior year's data
-- one record for each actor.  This record has an array that lists all of the actor's films up to that year
	,yesterday as (
	    select * from actors
	    where current_year = 1979
)

-- today. current year's data
-- aggregate the actor's data so that there is one record per actor listing all of the actor's films for the year
    ,today as (

		select actor, actorid, avg_rating, year as current_year, array_agg(row(year, film, votes, rating, filmid)::films) as films
		from actor_films_with_avgrating
		where year = 1980
		group by actor, actorid, avg_rating, year
)

-- Create a new record for insert into actor_scd
-- If the actor has films in today, append those films to the films in yesterday to create a new record
-- If the actor does not have in films in today, bring forward the films in yesterday to create a new record
-- If the actor does not have any films in yesterday, create a new record 
-- Assign quality_class category rating based on average rating of films for an actor
-- Set is_active to True if the actor has records in today, False if not

     
	select 
		coalesce(t.actorid, y.actorid) as actorid,
		coalesce(t.actor, y.actor) as actor,
		
		coalesce(t.current_year, y.current_year + 1) as current_year,
		case when y.films is null then t.films
			 when t.films is not null then t.films || y.films
			 else y.films
		end as films,
			
			case 
				when t.current_year is not null then
					case when t.avg_rating > 8 then 'star'
					     when t.avg_rating > 7 and t.avg_rating <= 8 then 'good'
					     when t.avg_rating > 6 and t.avg_rating <= 7 then 'average'
					     when t.avg_rating <= 6 then 'bad'
					     
					end :: quality_class
				else y.quality_class
			end as quality_class,
			case 
				when t.current_year is not null then true 
				else false 
			end as is_active
				
			
	from today t 
	full outer join yesterday y
	on t.actorid = y.actorid

	
-- Queries	

-- Actors table post-inserts.  Data from 1970 to 1980.
select * 
from actors 
where current_year = 1980	
order by actor


-- Create a temporary table. Unnest the data type films.  Select the year 1980.

create temp table actor_films_1970t1980 as 
select actor, current_year, unnest(films):: films as activity 
from actors
where current_year = 1980;

-- Actors table unnested

select *
from actor_films_1970t1980
order by actor, (activity).year desc


-- Which films had a rating >= 9?

select (activity::films).year as film_year, (activity::films).film as film, (activity).rating
from actor_films_1970t1980
group by actor_films_1970t1980.activity
having (activity).rating >= 9;

-- List Fred Astaire's films

select actor, (activity).year, (activity).film, (activity).rating
from actor_films_1970t1980
where actor = 'Fred Astaire';

-- Which actors starred in more than 30 films from 1970 to 1980?

select actor, count((activity).film) as num_films
from actor_films_1970t1980
group by actor
having count((activity).film) > 30
order by num_films desc;


-- Which actors were in the film The Blues Brothers?

select actor, (activity).year, (activity).film  
from actor_films_1970t1980
where (activity).film = 'The Blues Brothers'
order by actor;


-- Which film(s) had the lowest rating?

with cte1 as (
select *,
min((activity).rating) over (order by (activity).rating) as lowest_rating
from actor_films_1970t1980
)

select (activity).year as year, 
(activity).film as film,
(activity).rating as rating
from cte1
where lowest_rating = (activity).rating;






