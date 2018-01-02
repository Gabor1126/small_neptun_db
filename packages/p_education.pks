SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE p_education IS

  ----------------------------------------------------------------------------------  
  -- Szak beszúrása
  PROCEDURE proc_insert_degrees(p_name 			IN	VARCHAR2,
                            p_traning_level IN			VARCHAR2,
                            p_department_id IN   NUMBER);
                            
  ----------------------------------------------------------------------------------
  -- Szakirány beszúrása
  PROCEDURE proc_insert_specialization(p_name 	IN			VARCHAR2,
                            p_degrees_id    IN   NUMBER,
                            p_department_id IN   NUMBER);

  ----------------------------------------------------------------------------------
  -- Tárgy beszúrása
  PROCEDURE proc_insert_subject(	p_name 			IN	VARCHAR2,
                            p_specialization_id IN NUMBER,
                            p_degrees_id IN NUMBER,
                            p_semester 		IN	NUMBER);

----------------------------------------------------------------------------------
-- Tanár-tantárgy beszúrása
  PROCEDURE proc_insert_teacher_subject(p_teacher_neptun_code IN VARCHAR2,
                            p_subject_code          IN VARCHAR2,
                            p_year IN VARCHAR2,
                            p_semester IN NUMBER);

----------------------------------------------------------------------------------
-- Diák-tanár-tárgy-érdemjegy beszúrása
  PROCEDURE proc_insert_student_subject(	p_student_neptun_code 			IN	VARCHAR2,
                            p_teacher_neptun_code          IN VARCHAR2,
                            p_subject_code IN VARCHAR2,
                            p_year IN VARCHAR2,
                            p_semester 		IN	NUMBER,
                            p_grade IN NUMBER);

----------------------------------------------------------------------------------
END p_education;
/