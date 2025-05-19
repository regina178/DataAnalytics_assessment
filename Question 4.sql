SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    
    COUNT(s.id) AS total_transactions,
    
    ROUND((
        (SUM(s.confirmed_amount / 100) / TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) 
        * 12 
        * 0.001
    ), 2) AS estimated_clv

FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON s.owner_id = u.id

WHERE 
    s.confirmed_amount IS NOT NULL

GROUP BY 
    u.id, name, tenure_months

ORDER BY 
    estimated_clv DESC;
    
    SHOW COLUMNS FROM savings_savingsaccount;

