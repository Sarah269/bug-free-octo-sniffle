# Cumulative Table Design

## Project
<p>Created a data model that facilitates efficient analysis of the actor_films dataset.  Populated the new table, actors, using a cumulative query. The 'actors' table will have an array of struct for the film attributes and an enum to categorize the quality of the film.</p>


<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/Actors%20Pipeline%20Design.png" height=250>


## Data 
 - input: actor_films
   
   <img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actor_films.png" height=250>

 - output: actors

   <img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/Cumulative%20Table%20Design/actors_table.png" height=250>

## Tasks
 - Create enum for actor's performance quality
   
<pre> create type quality_class as enum ('star', 'good', 'average', 'bad') </pre>

- create an array of struct for film attributes
  
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

- Create a cumulative query to populate the actors table one year at a time



- Actor table


- 

  
