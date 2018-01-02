DROP FUNCTION func_select_student_is_active;

CREATE FUNCTION func_select_student_is_active(student_neptun_code IN VARCHAR2)
   RETURN NUMBER
   IS is_active NUMBER;
   BEGIN
      SELECT t.active
      INTO is_active 
      FROM t_student t
      WHERE t.neptun_code = student_neptun_code;
      RETURN(is_active); 
    END;
/
