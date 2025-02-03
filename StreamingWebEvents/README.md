# Streaming Web Events

## Project
Create a Flink job to capture web activity for a family of websites in real-time, sessionize data on IP and host with a 5 minute gap,  and store the aggregated data in a Postgres table.

<p float=left>
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/StreamingWebEvents/processed_events_flow.png" width="40%">
<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/StreamingWebEvents/agg_events_flow.png" width="58%">
</p>

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/StreamingWebEvents/WebEventsDashboard.png" height=300>

## Reference
- DataExpert.io Free Data Engineering Bootcamp

## Tools
- Docker, Pyflink, Apache Kafka, Postgres, PostgresSQL, Power BI

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

## Apache Flink UI

<img src="https://github.com/Sarah269/bug-free-octo-sniffle/blob/main/StreamingWebEvents/ApacheFlinkDashboard.png" height=250>

## aggregation2_job.py
- create_agg_session_events_ip_sink_postgres
   - define aggregation table

- create_processed_events_source_kafka
   - define detailed events table

- log_aggregation
   - aggregate data on IP and host using session windowing with a 5 minute gap and write to session_events_aggregated_ip

## start_job.py
- create_processed_events_sink_kafka
   - Define table process_events_kafka to kafka

- create_processed_events_sink_postgres
   - Define table processed_events table to postgres

- user-defined function GetLocation
   - Call to api.ip2location.io to get country, state, city information on each IP 

- create_events_source_kafka
   - define table events to kafka

- log_processing
   - start flink job
   - retrieve data and insert into processed_events table
 
## Execute flink jobs
- docker compose exec jobmanager flink run -py /opt/src/job/start_job.py  -- pyFiles /opt/src -d
- docker compose exec jobmanager flink run -py /opt/src/job/aggregation2_job.py  --pyFiles /opt/src -d

## Query processed_events



## Query session_events_aggregated_ip

