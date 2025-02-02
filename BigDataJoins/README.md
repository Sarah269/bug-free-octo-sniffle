# BigDataJoins

## Project
Build a Spark job that joins five datasets using broadcast and bucket joins

<p float="left">
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/BigDataJoins1.png" width="49%">
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/BigDataJoins2.png" width="49%">
</p>
<p float="left">
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/BigDataJoins3.png" width="49%">
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/BigDataJoins4.png" width="49%">
</p>

## Reference
- DataExpert.io Free Data Engineering bootcamp

## Tools
- Docker, Python, Pandas, Pyspark, Spark, Iceberg, Jupyter Notebook, Google Sheets

## Input
- maps (40 rows)
- matches (24025 rows)
- medals (183 rows)
- matchDetails (151761 rows)
- medalsMatchesPlayers (755229 rows)

## Output
- gamingInfo
- agg_gamer_games

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Aggregated_gamer_games.png" height=250>

## Tasks
- Read csv file(s) into a dataframe(s)
- Rename select column names
- Perform broadcast joins
- Create iceberg tables with 16 buckets
- Perform bucket joins
- Create iceberg table for bucket join result
- Aggregate joined data
- Query data

## Spark Job
- [Spark job jupyter notebook](https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Spark_Joins.ipynb)
  
## Queries

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Q1_Most_kills_per_game.png" height=250>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Q2_playlist_most_played.png" height=250>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Q3_map_played_most.png" height=250>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/BigDataJoins/Q4_map_most_killingspree_medals.png" height=250>

  


