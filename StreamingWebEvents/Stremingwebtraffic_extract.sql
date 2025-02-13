-- Web Traffic By Country, State

select 
geodata::json->> 'country' as country,
geodata::json->> 'state' as state,
count(*) 
from processed_events pe 
where geodata::json->> 'country' is not null
group by geodata::json->> 'country' , geodata::json->> 'state' 
order by country