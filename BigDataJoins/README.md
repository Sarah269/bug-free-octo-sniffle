# BigDataJoins

## Project
Build a Spark job that joins five datasets using broadcast and bucket joins

## Tools
- Docker, Python, Pyspark, Spark, Iceberg, Jupyter Notebook

## Input
- maps (40 rows)
- matches (24025 rows)
- medals (183 rows)
- matchDetails (151761 rows)
- medalsMatchesPlayers (755229 rows)

## Output
- gamingInfo

## Tasks
- Read csv file(s) into a dataframe(s)
- Rename select column names
- Perform broadcast joins
- Create iceberg tables with 16 buckets
- Perform bucket joins
- Create iceberg table for bucket join result
- Aggregate joined data
- Query data


