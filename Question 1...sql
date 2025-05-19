SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_a_fund = 1 THEN 'Investment'
        WHEN p.is_a_wallet = 1 THEN 'Wallet'
        WHEN p.is_emergency_plan = 1 THEN 'Emergency'
        ELSE 'Savings'
    END AS plan_type,
    p.last_charge_date,
    DATEDIFF(CURRENT_DATE(), COALESCE(p.last_charge_date, p.created_on)) AS inactivity_days,
    p.amount AS current_balance
FROM 
    plans_plan p
WHERE 
    p.status_id = 1 -- Active
    AND p.is_deleted = 0
    AND (
        p.last_charge_date IS NULL 
        OR p.last_charge_date < DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
    )
    AND p.amount > 0 -- Has funds
ORDER BY 
    inactivity_days DESC;