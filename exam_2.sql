SELECT A.*,
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 1 AND A.id = B.teacher_id) AS "Open",
	(SELECT COUNT(*) FROM trn_time_table B WHERE  B.`status` = 3 AND A.id = B.teacher_id) AS "Reserved",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 1 AND A.id = C.teacher_id) AS "Taught",
	(SELECT COUNT(*) FROM trn_evaluation C WHERE  C.`result` = 2 AND A.id = C.teacher_id) AS "No Show"
FROM
	(SELECT id AS `ID`, `Nickname` FROM trn_teacher WHERE `status` != 0 GROUP BY ID) AS A