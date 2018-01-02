CREATE OR REPLACE VIEW teacher_student_view AS 
   SELECT(t.first_name || ' ' || t.last_name) AS TANAR_NEVE,
   su.name AS TARGY, 
   ts.year AS EV,
   ts.semester AS SEMESTER
   FROM t_teacher_semester ts INNER JOIN t_teacher t ON ts.teacher_id = t.id
   INNER JOIN t_subject su ON ts.subject_id = su.id;
   /