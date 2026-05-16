{% macro calculate_sla_status(resolution_hours, priority) %}
    case
        when {{ priority }} = 'Critical' and {{ resolution_hours }} > 4 then 'Breached'
        when {{ priority }} = 'High' and {{ resolution_hours }} > 12 then 'Breached'
        when {{ priority }} = 'Medium' and {{ resolution_hours }} > 24 then 'Breached'
        when {{ priority }} = 'Low' and {{ resolution_hours }} > 48 then 'Breached'
        else 'Met'
    end
{% endmacro %}
