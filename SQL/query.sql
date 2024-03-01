SELECT Month, customers.account_id as Account, totalAmountIn, totalAmountOut, (totalAmountIn - totalAmountOut) as Balance
FROM
	({}) AS totalInAndOut

INNER JOIN
	({}) as customers
ON
	totalInAndOut.account_id = customers.account_id
    order by Month ASC