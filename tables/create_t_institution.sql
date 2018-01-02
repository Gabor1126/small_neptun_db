DROP TABLE t_institution CASCADE CONSTRAINTS;

CREATE TABLE t_institution(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	name 				VARCHAR2(100) 		NOT NULL,
        short_name 				VARCHAR2(5) 		NOT NULL,
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255)
) TABLESPACE neptun_tablespace;