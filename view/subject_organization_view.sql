CREATE OR REPLACE VIEW subject_organization_view AS 
    SELECT s.name AS TARGY_NEVE,
    d.name AS SZAK,
    de.name AS TANSZEK,
    i.name AS INTEZET
    FROM t_subject s INNER JOIN t_degrees d ON s.degrees_id  = d.id
    INNER JOIN t_department de ON d.department_id = de.id
    INNER JOIN t_institution i ON de.insitution_id = i.id;
   /
