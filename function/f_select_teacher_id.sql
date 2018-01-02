DROP FUNCTION func_select_teacher_id;

CREATE FUNCTION func_select_teacher_id(teacher_neptun_code IN VARCHAR2)
   RETURN NUMBER 
   IS teacher_id NUMBER;
   BEGIN
      SELECT t.id 
      INTO teacher_id 
      FROM t_teacher t 
      WHERE t.neptun_code = teacher_neptun_code;
      RETURN(teacher_id); 
    END;
/
