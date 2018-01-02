create table t_error_log(
       err_id NUMBER,
       err_time TIMESTAMP 	DEFAULT SYSDATE NOT NULL,
       err_message VARCHAR2(4000),
       err_value VARCHAR2(4000),
       api VARCHAR2(100)
);
/