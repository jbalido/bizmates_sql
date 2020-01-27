## Write a query to display the ff columns ID (should start
## with T + 11 digits of trn_teacher.id with leading zeros like
## 'T00000088424'), Nickname, Status and Roles (like
## Trainer/Assessor/Staff) using table trn_teacher and
## trn_teacher_role.

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

##Write a query to display the ff columns ID (from teacher.id),
##Nickname, Open (total open slots from trn_teacher_time_table),
##Reserved (total reserved slots from trn_teacher_time_table),
##Taught (total taught from trn_evaluation) and NoShow (total
##no_show from trn_evaluation) using all tables above. Should
##show only those who are active (trn_teacher.status = 1 or 2)
##and those who have both Trainer and Assessor role.

SELECT A.*,
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 1 AND A.id = B.teacher_id) AS "Open",
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 3 AND A.id = B.teacher_id) AS "Reserved",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 1 AND A.id = C.teacher_id) AS "Taught",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 2 AND A.id = C.teacher_id) AS "No Show"
FROM
	(SELECT id AS `ID`, `Nickname` FROM trn_teacher WHERE `status` != 0 GROUP BY ID) AS A