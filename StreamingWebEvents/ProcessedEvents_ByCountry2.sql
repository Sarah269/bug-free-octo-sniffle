-- Web Traffic By Country

with cte as (
select geodata::json->> 'country' as country, count(*) as num_hits
from processed_events pe  
where  geodata::json->> 'country' is not null
group by geodata::json->> 'country'

)

select country, num_hits,
sum(num_hits) over() as tot_hits, num_hits/sum(num_hits) over() as perc_traffic
from cte
order by perc_traffic desc