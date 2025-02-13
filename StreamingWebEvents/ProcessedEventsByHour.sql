-- Web Traffic By Hour

with cte as(
select extract(hour from event_timestamp) as hour, count(*) as num_hits
from processed_events pe 
where event_timestamp is not null
group by extract(hour from event_timestamp)
)

select hour, num_hits, num_hits/sum(num_hits) over() as perc_hits
from cte
order by perc_hits desc