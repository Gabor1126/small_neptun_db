SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE p_error IS

  ----------------------------------------------------------------------------------  
  PROCEDURE proc_err_log(p_err_message varchar2,
                    p_err_value   varchar2,
                    p_api         varchar2);
  ----------------------------------------------------------------------------------  
END p_error;
/