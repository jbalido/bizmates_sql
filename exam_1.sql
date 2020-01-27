SELECT 
	CONCAT('T',LPAD(t1.`id`,11,0) ) AS `ID`,
	`Nickname`,
	CASE STATUS
		WHEN 0 THEN 'Discontinued' 
		WHEN 1 THEN 'Active' 
	ELSE 'Deactivated' 
	END
	AS `Status`,
	GROUP_CONCAT(
	DISTINCT 
	CASE role
		WHEN 1 THEN 'Trainer' 
		WHEN 2 THEN 'Assessor' 
	ELSE 'Staff' 
	END SEPARATOR '/') 
	AS `Role`
FROM trn_teacher t1 JOIN trn_teacher_role t2 ON t1.`id` = t2.`teacher_id` GROUP BY ID ORDER BY ID DESC