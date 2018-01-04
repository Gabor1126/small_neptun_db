DROP TABLE t_specialization CASCADE CONSTRAINTS;

CREATE TABLE t_specialization(
	id 				NUMBER 			NOT NULL PRIMARY KEY,
	name 				VARCHAR2(100),
    degrees_id       NUMBER 			NOT NULL,
    department_id    NUMBER NOT NULL,
    version 		NUMBER,
    dml_flag 		VARCHAR2(1),
    created_date			DATE 			DEFAULT SYSDATE NOT NULL,
    modified_by     VARCHAR2(255),
    CONSTRAINT fk_specialization_degrees FOREIGN KEY (degrees_id) REFERENCES t_degrees(id),
    CONSTRAINT fk_specialization_department FOREIGN KEY (department_id) REFERENCES t_department(id)
) TABLESPACE neptun_tablespace;