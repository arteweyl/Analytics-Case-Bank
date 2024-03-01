SELECT
    accounts.account_id 
FROM 
    accounts 
LEFT JOIN 
    customers ON accounts.customer_id  = customers.customer_id