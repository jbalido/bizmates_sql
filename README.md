# Question 1
```
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
```

# Question 2
```
SELECT A.*,
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 1 AND A.id = B.teacher_id) AS "Open",
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 3 AND A.id = B.teacher_id) AS "Reserved",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 1 AND A.id = C.teacher_id) AS "Taught",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 2 AND A.id = C.teacher_id) AS "No Show"
FROM
	(SELECT id AS `ID`, `Nickname` FROM trn_teacher WHERE `status` != 0 GROUP BY ID) AS A
```