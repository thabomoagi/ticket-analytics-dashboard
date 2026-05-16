with tickets as (
    select * from {{ ref('fct_ticket_performance') }}
)

select
    assigned_agent,
    
    -- Volume metrics
    count(*) as total_tickets,
    
    -- Resolution metrics
    round(avg(resolution_hours), 2) as avg_resolution_time,
    
    -- SLA metrics
    sum(case when sla_status = 'Breached' then 1 else 0 end) as sla_breaches,
    round(
        100.0 * sum(case when sla_status = 'Breached' then 1 else 0 end) / count(*), 
        2
    ) as sla_breach_rate,
    
    -- Priority breakdown
    sum(case when priority = 'Critical' then 1 else 0 end) as critical_tickets,
    sum(case when priority = 'High' then 1 else 0 end) as high_tickets

from tickets

group by assigned_agent

order by sla_breach_rate asc, avg_resolution_time asc
