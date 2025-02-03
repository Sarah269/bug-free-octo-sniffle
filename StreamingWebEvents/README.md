# Streaming Web Events

## Project
Capture web activity in real-time and store in Postgres table


## Reference
- DataExpert.io Free Data Engineering Bootcamp

## Tools
- Pyflink, Apache Kafka, Postgres, PostgresSQL, Power BI

## DDL processed_events
<pre>
   CREATE TABLE processed_events (
            ip VARCHAR,
            event_timestamp TIMESTAMP(3),
            referrer VARCHAR,
            host VARCHAR,
            url VARCHAR,
            geodata VARCHAR);
</pre>

## DDL session_events_aggregated_ip
<pre>
  CREATE TABLE processed_events (
            start_session TIMESTAMP(3),
            end_session TIMESTAMP(3),
            ip VARCHAR,
            host VARCHAR,
            web_events BIGINT);
</pre>





