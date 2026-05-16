with tickets as (
    select * from {{ ref('fct_ticket_performance') }}
)

select
    category,
    priority,
    
    -- Volume
    count(*) as ticket_count,
    
    -- Resolution performance
    round(avg(resolution_hours), 2) as avg_resolution_time,
    
    -- SLA compliance
    sum(case when sla_status = 'Breached' then 1 else 0 end) as sla_breaches,
    round(
        100.0 * sum(case when sla_status = 'Breached' then 1 else 0 end) / count(*),
        2
    ) as sla_breach_rate,
    
    -- Time range
    min(created_date) as first_ticket,
    max(created_date) as last_ticket

from tickets

group by category, priority

order by sla_breach_rate desc, ticket_count desc
