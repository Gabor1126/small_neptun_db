DROP FUNCTION func_select_subject_id;

CREATE FUNCTION func_select_subject_id(subject_code IN VARCHAR2)
   RETURN NUMBER 
   IS subject_id NUMBER;
   BEGIN
      SELECT t.id 
      INTO subject_id 
      FROM t_subject t 
      WHERE t.code = subject_code;
      RETURN(subject_id); 
    END;
/
