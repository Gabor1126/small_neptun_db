SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE BODY p_people IS

  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_student(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_relationship IN	VARCHAR2,
                            p_end_of_relationship 	IN	VARCHAR2,
                            p_act_semester 		IN	NUMBER,
                            p_degrees_id IN	NUMBER,
                            p_specialization_id 	IN		NUMBER,
                            p_active       IN         NUMBER) IS
  
  BEGIN
      INSERT INTO t_student t
        (t.first_name,
        t.last_name,
        t.birth_date,
        t.birth_place_city,
        t.loc_city,
        t.loc_address,
        t.email,
        t.tel,
        t.beggining_of_relationship,
        t.end_of_relationship,
        t.act_semester,
        t.degrees_id,
        t.specialization_id,
        t.neptun_code,
        t.active,
        t.modified_by)
      VALUES
        (p_first_name,
        p_last_name,
        to_date(p_birth_date, 'YYYY.MM.DD'),
        p_birth_place_city,
        p_loc_city,
        p_loc_address,
        p_email,
        p_tel,
        to_date(p_beggining_of_relationship, 'YYYY.MM.DD'),
        to_date(p_end_of_relationship, 'YYYY.MM.DD'),
        p_act_semester,
        p_degrees_id,
        p_specialization_id,
        DBMS_RANDOM.string('x',6),
        p_active,
        user);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_first_name=' || p_first_name
                            || CHR(10) || 'p_last_name=' || p_last_name,
                            p_api         => 'p_people.proc_insert_student');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_update_student(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_relationship IN	VARCHAR2,
                            p_end_of_relationship 	IN	VARCHAR2,
                            p_act_semester 	IN		NUMBER,
                            p_degrees_id 	IN NUMBER,
                            p_specialization_id 	IN		NUMBER,
                            p_active        IN        NUMBER,
                            p_neptun_code   IN VARCHAR2) IS
   v_any_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Hallgató nem található!';
  BEGIN
    SELECT COUNT(*) INTO v_any_rows_found FROM t_student t WHERE t.neptun_code = p_neptun_code;
    IF v_any_rows_found = 0 THEN
      RAISE v_row_not_found_exception;
    ELSE
      UPDATE t_student t
        SET t.first_name = p_first_name,
        t.last_name = p_last_name,
        t.birth_date = to_date(p_birth_date, 'YYYY.MM.DD'),
        t.birth_place_city = p_birth_place_city,
        t.loc_city = p_loc_city,
        t.loc_address = p_loc_address,
        t.email = p_email,
        t.tel = p_tel,
        t.beggining_of_relationship = to_date(p_beggining_of_relationship, 'YYYY.MM.DD'),
        t.end_of_relationship = to_date(p_end_of_relationship, 'YYYY.MM.DD'),
        t.act_semester = p_act_semester,
        t.degrees_id = p_degrees_id,
        t.specialization_id = p_specialization_id,
        t.active = p_active,
        t.modified_by = user
        WHERE t.neptun_code = p_neptun_code;
        COMMIT;
    END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code,
                            p_api         => 'p_people.proc_update_student');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code || CHR(10) || 'p_first_name=' || p_first_name
                            || CHR(10) || 'p_last_name=' || p_last_name,
                            p_api         => 'p_people.proc_update_student');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_delete_student(p_neptun_code IN VARCHAR2) IS
  v_is_yet_active EXCEPTION;
  v_is_active NUMBER;
  v_error_message varchar2(4000) := 'Nem törölhetõ, mert még aktív a hallgató!';
  BEGIN
    v_is_active := func_select_student_is_active(p_neptun_code);
    IF v_is_active = 1 THEN
      RAISE v_is_yet_active;
    ELSE
      DELETE FROM t_student t
        WHERE t.neptun_code = p_neptun_code;
    END IF;
    EXCEPTION
        WHEN v_is_yet_active THEN
         p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code,
                            p_api         => 'p_people.proc_delete_student');

  END;
  ----------------------------------------------------------------------------------
  
  PROCEDURE proc_activate_student(p_neptun_code IN VARCHAR2) IS
  v_is_yet_active EXCEPTION;
  v_is_active NUMBER;
  v_error_message varchar2(4000) := 'Nem aktíválható, mert már aktív a hallgató!';
  BEGIN
    v_is_active := func_select_student_is_active(p_neptun_code);
    IF v_is_active = 1 THEN
      RAISE v_is_yet_active;
    ELSE
      UPDATE t_student t
        SET t.active = 1
        WHERE t.neptun_code = p_neptun_code;
    END IF;
    EXCEPTION
        WHEN v_is_yet_active THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code,
                            p_api         => 'p_people.proc_activate_student');
  END;
  ----------------------------------------------------------------------------------
  
  PROCEDURE proc_passivate_student(p_neptun_code IN VARCHAR2) IS
  v_is_yet_active EXCEPTION;
  v_is_active NUMBER;
  v_error_message varchar2(4000) := 'Nem passzíváltatható, mert már passzív a hallgató!';
  BEGIN
  v_is_active := func_select_student_is_active(p_neptun_code);
    IF v_is_active = 0 THEN
      RAISE v_is_yet_active;
    ELSE
      UPDATE t_student t
        SET t.active = 0
        WHERE t.neptun_code = p_neptun_code;
    END IF;
    EXCEPTION
        WHEN v_is_yet_active THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code,
                            p_api         => 'p_people.proc_passivate_student');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_teacher(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_work IN		VARCHAR2,
                            p_department_id IN          NUMBER) IS
  
  BEGIN
      INSERT INTO t_teacher t
        (t.first_name,
        t.last_name,
        t.birth_date,
        t.birth_place_city,
        t.loc_city,
        t.loc_address,
        t.email,
        t.tel,
        t.beggining_of_work,
        t.neptun_code,
        t.department_id,
        t.modified_by)
      VALUES
        (p_first_name,
        p_last_name,
        to_date(p_birth_date, 'YYYY.MM.DD'),
        p_birth_place_city,
        p_loc_city,
        p_loc_address,
        p_email,
        p_tel,
        to_date(p_beggining_of_work, 'YYYY.MM.DD'),
        DBMS_RANDOM.string('x',6),
        p_department_id,
        user);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_first_name=' || p_first_name
                            || CHR(10) || 'p_last_name=' || p_last_name,
                            p_api         => 'p_people.proc_insert_teacher');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_update_teacher(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_work IN		VARCHAR2,
                            p_department_id IN          NUMBER,
                            p_neptun_code   IN VARCHAR2) IS
   v_any_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Tanár nem található!';
  BEGIN
    SELECT COUNT(*) INTO v_any_rows_found FROM t_teacher t WHERE t.neptun_code = p_neptun_code;
    IF v_any_rows_found = 0 THEN
      RAISE v_row_not_found_exception;
    ELSE
      UPDATE t_teacher t
        SET t.first_name = p_first_name,
        t.last_name = p_last_name,
        t.birth_date = to_date(p_birth_date, 'YYYY.MM.DD'),
        t.birth_place_city = p_birth_place_city,
        t.loc_city = p_loc_city,
        t.loc_address = p_loc_address,
        t.email = p_email,
        t.tel = p_tel,
        t.beggining_of_work = to_date(p_beggining_of_work, 'YYYY.MM.DD'),
        t.department_id = p_department_id,
        t.modified_by = user
        WHERE t.neptun_code = p_neptun_code;
        COMMIT;
    END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code,
                            p_api         => 'p_people.proc_update_teacher');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_neptun_code=' || p_neptun_code || CHR(10) || 'p_first_name=' || p_first_name
                            || CHR(10) || 'p_last_name=' || p_last_name,
                            p_api         => 'p_people.proc_update_teacher');
  END;
  ----------------------------------------------------------------------------------
END p_people;
/
