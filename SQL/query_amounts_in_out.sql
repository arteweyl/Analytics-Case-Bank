SELECT	
    account_id,
    pix_completed_at as time_id,
    (CASE WHEN in_or_out = 'pix_in' THEN pix_amount END) AS totalAmountIn,
    (CASE WHEN in_or_out = 'pix_out' THEN pix_amount END) AS totalAmountOut
FROM 
    pix_movements
WHERE
    pix_completed_at != 'None'
    
UNION ALL

SELECT 
    account_id,
    transaction_completed_at AS time_id, 
    amount AS totalAmountIn, 
    NULL AS totalAmountOut
FROM 
	transfer_ins
WHERE 
	transaction_completed_at != 'None'
    
UNION ALL
	SELECT 
        account_id,
        transaction_completed_at AS time_id, 
        NULL AS totalAmountIn, 
        amount as totalAmountOut
	FROM
        transfer_outs
	WHERE
         transaction_completed_at != 'None'