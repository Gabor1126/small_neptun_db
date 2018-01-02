create or replace package body p_error is

  procedure proc_err_log(p_err_message varchar2,
                    p_err_value   varchar2,
                    p_api         varchar2) is
      pragma autonomous_transaction;
    begin
      insert into t_error_log
        (err_id, err_message, err_value, api)
      values
        (error_seq.nextval, p_err_message, p_err_value, p_api);
      commit;
    end;
end p_error;
/