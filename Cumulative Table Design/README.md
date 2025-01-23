# Cumulative Table Design

## Project
Model the actor_films dataset in way that facilitates efficient analysis.

## Data 
 - input: actor_films
 - output: actors

## Design





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

- Create a cumulative query to populate the actors table one year at a time.
- Query the actors table

  
