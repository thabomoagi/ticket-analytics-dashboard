with tickets as (
    select * from {{ ref('fct_ticket_performance') }}
)

select
    date_trunc('day', created_date) as ticket_date,
    
    -- Volume metrics
    count(*) as tickets_created,
    count(distinct assigned_agent) as agents_active,
    
    -- Priority breakdown
    sum(case when priority = 'Critical' then 1 else 0 end) as critical_count,
    sum(case when priority = 'High' then 1 else 0 end) as high_count,
    
    -- SLA metrics
    sum(case when sla_status = 'Breached' then 1 else 0 end) as sla_breaches,
    round(
        100.0 * sum(case when sla_status = 'Breached' then 1 else 0 end) / count(*),
        2
    ) as sla_breach_rate,
    
    -- Resolution metrics
    round(avg(resolution_hours), 2) as avg_resolution_time

from tickets

group by date_trunc('day', created_date)

order by ticket_date
