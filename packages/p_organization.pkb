SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE BODY p_organization IS

  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_institution(p_name 	IN VARCHAR2,
                                p_short_name IN VARCHAR2) IS
  
  BEGIN
      INSERT INTO t_institution t
        (t.name,
        t.short_name,
        t.modified_by)
      VALUES
        (p_name
        ,p_short_name
        ,user);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_short_name=' || p_short_name,
                            p_api         => 'p_organization.t_institution');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_update_institution(p_id IN NUMBER,
                            p_name 			IN	VARCHAR2,
                            p_short_name IN VARCHAR2) IS
    v_any_rows_found NUMBER;
    v_row_not_found_exception EXCEPTION;
    v_error_message varchar2(4000) := 'Intézet nem található!';
  BEGIN
      SELECT COUNT(*) INTO v_any_rows_found FROM t_institution t WHERE t.id = p_id;
      IF v_any_rows_found = 0 THEN
        RAISE v_row_not_found_exception;
      ELSE
          UPDATE t_institution t
            SET t.name = p_name,
            t.short_name = p_short_name,
            t.modified_by = user
            WHERE t.id = p_id;
            COMMIT;
      END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_id=' || p_id,
                            p_api         => 'p_organization.proc_update_institution');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_id=' || p_id|| CHR(10) || 'p_name=' || p_name
                            || CHR(10) || 'p_short_name=' || p_short_name,
                            p_api         => 'p_organization.proc_update_institution');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_insert_department(p_name IN VARCHAR2,
                               p_short_name IN VARCHAR2,
                               p_insitution_id  IN NUMBER) IS
   v_any_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Tanszék beszúrásakor létezõ intézetet kell megadni!';
  BEGIN
      SELECT COUNT(*) INTO v_any_rows_found FROM t_institution t WHERE t.id = p_insitution_id;
      IF v_any_rows_found = 0 THEN
        RAISE v_row_not_found_exception;
      ELSE
          INSERT INTO t_department t
            (t.name,
            t.short_name,
            t.insitution_id,
            t.modified_by)
          VALUES
            (p_name
            ,p_short_name
            ,p_insitution_id
            ,user);
            COMMIT;
      END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_insitution_id=' || p_insitution_id,
                            p_api         => 'p_organization.proc_insert_department');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_name=' || p_name || CHR(10) || 'p_short_name=' || p_short_name
                            || CHR(10) || 'p_insitution_id=' || p_insitution_id,
                            p_api         => 'p_organization.proc_insert_department');
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE proc_update_department(p_id IN NUMBER,
                              p_name IN	VARCHAR2,
                              p_short_name IN VARCHAR2,
                               p_insitution_id IN  NUMBER) IS
   v_any_rows_found NUMBER;
   v_row_not_found_exception EXCEPTION;
   v_error_message varchar2(4000) := 'Tanszék nem található!';
  BEGIN
    SELECT COUNT(*) INTO v_any_rows_found FROM t_department t WHERE t.id = p_id;
    IF v_any_rows_found = 0 THEN
      RAISE v_row_not_found_exception;
    ELSE
        UPDATE t_department t
            SET t.name = p_name,
            t.short_name = p_short_name,
            t.insitution_id = p_insitution_id,
            t.modified_by = user
            WHERE t.id = p_id;
            COMMIT;
    END IF;
    EXCEPTION
        WHEN v_row_not_found_exception THEN
        p_error.proc_err_log(p_err_message => v_error_message,
                            p_err_value   => 'p_id=' || p_id,
                            p_api         => 'p_organization.proc_update_department');
        WHEN OTHERS THEN
        p_error.proc_err_log(p_err_message => DBMS_UTILITY.FORMAT_ERROR_STACK || CHR(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                            p_err_value   => 'p_id=' || p_id|| CHR(10) || 'p_name=' || p_name
                            || CHR(10) || 'p_short_name=' || p_short_name || CHR(10) || 'p_insitution_id=' || p_insitution_id,
                            p_api         => 'p_organization.proc_update_department');
  END;
  ----------------------------------------------------------------------------------
END p_organization;
/
