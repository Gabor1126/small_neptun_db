CREATE OR REPLACE VIEW student_grade_view AS 
   SELECT (s.first_name || ' ' || s.last_name) AS DIAK_NEVE, 
   su.name AS TARGY, 
   (t.first_name || ' ' || t.last_name) AS TANAR_NEVE,
   sts.year AS EV,
   sts.semester AS SEMESTER,
   sts.grade AS JEGY
   FROM t_student_semester sts INNER JOIN t_student s ON sts.student_id = s.id 
   INNER JOIN t_subject su ON sts.subject_id = su.id
   INNER JOIN t_teacher t ON sts.teacher_id = t.id;
   /