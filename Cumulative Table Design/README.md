# Cumulative Table Design

## Project
<p>Create a data model that facilitates efficient analysis of the actor_films dataset.  Populate the new dimension table, actors, using a cumulative query. </p>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/Actors%20Pipeline%20Design.png" height=200>

## Reference
-  DataExpert.io Free Data Engineering Bootcamp
  
## Data 
 - input: actor_films
   
   <img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actor_films.png" height=200>

 - output: actors

   <img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actors_table.png" height=200>

## Tasks
 - Create enum for actor's performance quality
   
<pre> create type quality_class as enum ('star', 'good', 'average', 'bad') </pre>

- Create an array of struct for film attributes
  
<pre>create type films as (
	year integer,
	film text,
	votes integer,
	rating real,
	filmid text
	);</pre>
  
 - Create DDL for actors table
   
   <pre>create table actors (
	actorid text,
	actor text,
	current_year integer,
	films films[],
	quality_class quality_class,
	is_active boolean
	);</pre>

- Create a cumulative query to populate the actors table one year at a time.  Populated table for years 1970 to 1980.
	- [Actor Cumulative Query](https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actors_cumulative.sql)

 ## Queries

-- Create a temporary table. Unnest the data type films.  Select the year 1980.

<pre>create temp table actor_films_1970t1980 as 
select actor, current_year, unnest(films):: films as activity 
from actors
where current_year = 1980;</pre>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actors_table_unnested.png" height=200>

- Actors in the film "The Blues Brothers"
<pre>select actor, (activity).year, (activity).film  
from actor_films_1970t1980
where (activity).film = 'The Blues Brothers'
order by actor;</pre>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/BluesBrothers.png" height=200>

- List Fred Astaire films from 1970 - 1980

<pre>select (activity::films).year as film_year, (activity::films).film as film, (activity).rating
from actor_films_1970t1980
group by actor_films_1970t1980.activity
having (activity).rating >= 9;</pre>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/FredAstaire.png" width=450>

- Which film(s) have the lowest rating?

<pre>with cte1 as (
select *,
min((activity).rating) over (order by (activity).rating) as lowest_rating
from actor_films_1970t1980
)

select (activity).year as year, 
(activity).film as film,
(activity).rating as rating
from cte1
where lowest_rating = (activity).rating;</pre>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/Lowest%20Rating.png" width=450>

- Which films have a rating >= 9?

<pre>select (activity::films).year as film_year, (activity::films).film as film, (activity).rating
from actor_films_1970t1980
group by actor_films_1970t1980.activity
having (activity).rating >= 9;</pre>
  
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/ratingGTE9.png" width=450>

- Which actors starred in more than 30 films from 1970 to 1980?
  
<pre>select actor, count((activity).film) as num_films
from actor_films_1970t1980
group by actor
having count((activity).film) > 30
order by num_films desc;</pre>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/FilmsGT30.png" width=450>
  
