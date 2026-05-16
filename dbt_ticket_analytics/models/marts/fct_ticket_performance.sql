with tickets as (
    select * from {{ ref('stg_tickets') }}
)

select
    ticket_id,
    created_date,
    resolved_date,
    priority,
    status,
    category,
    assigned_agent,
    resolution_hours,
    is_it_late,
    sla_status,
    
    -- Time dimensions for reporting
    date_trunc('week', created_date) as created_week,
    date_trunc('month', created_date) as created_month
    
from tickets
