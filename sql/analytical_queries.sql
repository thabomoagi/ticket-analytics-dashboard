-- 1. Total Tickets Overview
SELECT COUNT(*) AS total_tickets
FROM tickets;
-- 2. Late Rate
SELECT ROUND(
        100.0 * SUM(
            CASE
                WHEN is_it_late = true THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS sla_breach_rate
FROM tickets;
-- 3. Volume by Priority
SELECT priority,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY priority
ORDER BY total_tickets DESC;
-- 4. Workload Drivers (Categories)
SELECT category,
    COUNT(*) AS ticket_count
FROM tickets
GROUP BY category
ORDER BY ticket_count DESC;
-- 5. Agent Speed Ranking
SELECT assigned_agent,
    COUNT(*) AS total_tickets,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_time
FROM tickets
GROUP BY assigned_agent
ORDER BY avg_resolution_time ASC;
-- 6. Agent Accountability (Who is late the most?)
SELECT assigned_agent,
    COUNT(*) AS total_tickets,
    SUM(
        CASE
            WHEN is_it_late = true THEN 1
            ELSE 0
        END
    ) AS breaches
FROM tickets
GROUP BY assigned_agent
ORDER BY breaches DESC;
-- 7. Daily Volume Trend
SELECT DATE(created_date) AS date,
    COUNT(*) AS tickets_created
FROM tickets
GROUP BY DATE(created_date)
ORDER BY date;