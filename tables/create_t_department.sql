DROP TABLE t_department CASCADE CONSTRAINTS;

CREATE TABLE t_department(
       	id				NUMBER 			NOT NULL PRIMARY KEY,
       	name 				VARCHAR2(100) 		NOT NULL,
        short_name 				VARCHAR2(5) 		NOT NULL,
        insitution_id   NUMBER          NOT NULL,
	version 			NUMBER,
	dml_flag 			VARCHAR2(1),
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_department_institution FOREIGN KEY (insitution_id) REFERENCES t_institution(id)
) TABLESPACE neptun_tablespace;