-- Custom test: No agent should have an SLA breach rate above 100%
select assigned_agent
from {{ ref('dim_agent_performance') }}
where sla_breach_rate > 100
