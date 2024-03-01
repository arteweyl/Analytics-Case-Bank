select time.action_month as Month, in_out.account_id as account_id, sum(ifnull(totalAmountIn,0)) as totalAmountIn, sum(ifnull(totalAmountOut,0)) as totalAmountOut
	from
	({}) as in_out
	inner join 
		({}) as time
	on 
		in_out.time_id = time.time_id
	group by in_out.account_id, time.action_month