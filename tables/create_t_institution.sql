DROP TABLE t_institution CASCADE CONSTRAINTS;

CREATE TABLE t_institution(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	name 				VARCHAR2(100) 		NOT NULL,
        short_name 				VARCHAR2(5) 		NOT NULL,
	version 			NUMBER,
	dml_flag 			VARCHAR2(1),
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255)
) TABLESPACE neptun_tablespace;