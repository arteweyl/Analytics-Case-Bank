SELECT Month, c.account_id as Account, totalAmountIn, totalAmountOut, (totalAmountIn - totalAmountOut) as balance
FROM
	(
	SELECT
		time.action_month as Month,
		in_out.account_id as account_id,
		sum(ifnull(totalAmountIn,0)) as totalAmountIn,
		sum(ifnull(totalAmountOut,0)) as totalAmountOut
	FROM
	(
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
	) as in_out
	inner join 
		(
			SELECT 
				action_month,
				time_id
			FROM 
				(d_time INNER JOIN d_year ON d_time.year_id = d_year.year_id)
			INNER JOIN 
				d_month ON d_time.month_id = d_month.month_id
			WHERE action_year=2020

		) as time
	on 
		in_out.time_id = time.time_id
	group by in_out.account_id, time.action_month	
	) AS totalInAndOut

INNER JOIN
	(
	SELECT
		accounts.account_id 
	FROM 
		accounts 
	LEFT JOIN 
		customers ON accounts.customer_id  = customers.customer_id
	) as c
ON
	totalInAndOut.account_id = c.account_id
    ORDER BY Month ASC;