SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE BODY p_education IS

  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_degrees(p_name 			IN	VARCHAR2,
                            p_traning_level  IN  VARCHAR2,
                            p_department_id  IN  NUMBER) IS
   v_any_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Tárgy beszúrásakor létezõ tanszéket kell megadni!';
  BEGIN
      SELECT COUNT(*) INTO v_any_rows_found FROM t_department t WHERE t.id = p_department_id;
      IF v_any_rows_found = 0 THEN
        RAISE v_row_not_found_exception;
      ELSE
          INSERT INTO t_degrees t
            (t.name,
            t.traning_level,
            t.department_id,
			t.version,
			t.dml_flag,
            t.modified_by)
          VALUES
            (p_name
            ,p_traning_level
            ,p_department_id
			,1
			,'I'
            ,user);
            COMMIT;
      END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_department_id=' || p_department_id,
                            p_api         => 'p_education.proc_insert_degrees');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_traning_level=' || p_traning_level
                            || CHR(10) || 'p_department_id=' || p_department_id,
                            p_api         => 'p_education.proc_insert_degrees');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_specialization(p_name 	IN			VARCHAR2,
                            p_degrees_id IN   NUMBER,
                            p_department_id  IN  NUMBER) IS
   v_department_rows_found NUMBER;
   v_degrees_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Szakirány beszúrásakor létezõ tanszéket és szakot kell megadni!';
  BEGIN
      SELECT COUNT(*) INTO v_department_rows_found FROM t_department t WHERE t.id = p_department_id;
      SELECT COUNT(*) INTO v_degrees_rows_found FROM t_degrees t WHERE t.id = p_degrees_id;
      
      IF v_department_rows_found = 0 OR v_degrees_rows_found = 0 THEN
        RAISE v_row_not_found_exception;
      ELSE
          INSERT INTO t_specialization t
            (t.name,
            t.degrees_id,
            t.department_id,
			t.version,
			t.dml_flag,
            t.modified_by)
          VALUES
            (p_name
            ,p_degrees_id
            ,p_department_id
			,1
			,'I'
            ,user);
            COMMIT;
      END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_degrees_id=' || p_degrees_id
                            || CHR(10) || 'p_department_id=' || p_department_id,
                            p_api         => 'p_education.proc_insert_specialization');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_degrees_id=' || p_degrees_id
                            || CHR(10) || 'p_department_id=' || p_department_id,
                            p_api         => 'p_education.proc_insert_specialization');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_subject(p_name 		IN		VARCHAR2,
                            p_specialization_id IN NUMBER,
                            p_degrees_id IN NUMBER,
                            p_semester 		IN	NUMBER) IS
   v_specialization_rows_found NUMBER;
   v_degrees_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Szakirány beszúrásakor létezõ szakot és szakirány megadása esetén létezõ tanszéket kell megadni!';
  BEGIN
      IF p_specialization_id IS NOT NULL THEN
        SELECT COUNT(*) INTO v_specialization_rows_found FROM t_specialization t WHERE t.id = p_specialization_id;
      END IF;
      
      SELECT COUNT(*) INTO v_degrees_rows_found FROM t_degrees t WHERE t.id = p_degrees_id;
      
      IF v_specialization_rows_found = 0 OR v_degrees_rows_found = 0 THEN
        RAISE v_row_not_found_exception;
      ELSE
          INSERT INTO t_subject t
            (t.name,
            t.code,
            t.specialization_id,
            t.degrees_id,
            t.semester,
			t.version,
			t.dml_flag,
            t.modified_by)
          VALUES
            (p_name
            ,DBMS_RANDOM.string('x',10)
            ,p_specialization_id
            ,p_degrees_id
            ,p_semester
			,1
			,'I'
            ,user);
            COMMIT;
      END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_degrees_id=' || p_degrees_id
                            || CHR(10) || 'p_specialization_id=' || p_specialization_id,
                            p_api         => 'p_education.proc_insert_subject');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_specialization_id=' || p_specialization_id
                            || CHR(10) || 'p_degrees_id=' || p_degrees_id || CHR(10) || 'p_semester=' || p_semester,
                            p_api         => 'p_education.proc_insert_subject');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_teacher_subject(p_teacher_neptun_code IN VARCHAR2,
                            p_subject_code          IN VARCHAR2,
                            p_year IN VARCHAR2,
                            p_semester IN NUMBER) IS
  
  v_teacher_id NUMBER;
  v_subject_id NUMBER;
  BEGIN
    v_teacher_id := func_select_teacher_id(p_teacher_neptun_code);
    v_subject_id := func_select_subject_id(p_subject_code);
    
      INSERT INTO t_teacher_semester t
        (t.teacher_id,
        t.subject_id,
        t.year,
        t.semester,
		t.version,
		t.dml_flag,
        t.modified_by)
      VALUES
        (v_teacher_id
        ,v_subject_id
        ,p_year
        ,p_semester
		,1
		,'I'
        ,user);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_teacher_neptun_code=' || p_teacher_neptun_code 
                            || CHR(10) || 'p_subject_code=' || p_subject_code
                            || CHR(10) || 'p_year=' || p_year
                            || CHR(10) || 'p_semester=' || p_semester,
                            p_api         => 'p_education.proc_insert_teacher_subject');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_student_subject(	p_student_neptun_code 			IN	VARCHAR2,
                            p_teacher_neptun_code          IN VARCHAR2,
                            p_subject_code IN VARCHAR2,
                            p_year IN VARCHAR2,
                            p_semester 		IN	NUMBER,
                            p_grade IN NUMBER) IS
  
  v_teacher_id NUMBER;
  v_student_id NUMBER;
  v_subject_id NUMBER;
  BEGIN
    SELECT t.id INTO v_student_id FROM t_student t WHERE t.neptun_code = p_student_neptun_code;
    v_teacher_id := func_select_teacher_id(p_teacher_neptun_code);
    v_subject_id := func_select_subject_id(p_subject_code);
    
      INSERT INTO t_student_semester t
        (t.student_id,
        t.subject_id,
        t.teacher_id,
        t.year,
        t.semester,
        t.grade,
		t.version,
		t.dml_flag,
        t.modified_by)
      VALUES
        (v_student_id
        ,v_subject_id
        ,v_teacher_id
        ,p_year
        ,p_semester
        ,p_grade
		,1
		,'I'
        ,user);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_student_neptun_code=' || p_student_neptun_code 
                            || CHR(10) || 'p_teacher_neptun_code=' || p_teacher_neptun_code
                            || CHR(10) || 'p_subject_code=' || p_subject_code
                            || CHR(10) || 'p_year=' || p_year
                            || CHR(10) || 'p_semester=' || p_semester
                            || CHR(10) || 'p_grade=' || p_grade,
                            p_api         => 'p_education.proc_insert_student_subject');
  END;
  ----------------------------------------------------------------------------------
END p_education;
/
