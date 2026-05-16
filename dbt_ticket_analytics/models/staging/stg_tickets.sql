with source as (
    select * from {{ source('raw', 'tickets') }}
),

renamed as (
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
        
        -- Use macro for consistent SLA logic
        {{ calculate_sla_status('resolution_hours', 'priority') }} as sla_status,
        
        -- Derived columns for cleanliness
        case priority
            when 'Critical' then 1
            when 'High' then 2
            when 'Medium' then 3
            when 'Low' then 4
        end as priority_order,
        
        extract(dow from created_date) as created_day_of_week,
        extract(hour from created_date) as created_hour
        
    from source
)

select * from renamed
