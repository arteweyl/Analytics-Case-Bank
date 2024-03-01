SELECT 
	action_month,
	time_id
FROM 
	(d_time INNER JOIN d_year ON d_time.year_id = d_year.year_id)
INNER JOIN 
	d_month ON d_time.month_id = d_month.month_id
WHERE action_year=2020
