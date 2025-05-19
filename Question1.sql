SELECT 
    p.owner_id,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 0 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(p.amount) AS total_deposits
FROM 
    plans_plan p
WHERE 
    p.status_id = 1 -- Active plans (assuming 1 means active)
    AND p.amount > 0 -- Funded plans
    AND p.is_deleted = 0 -- Not deleted
GROUP BY 
    p.owner_id
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 0 THEN p.id END) > 0
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) > 0
ORDER BY total_deposits DESC;