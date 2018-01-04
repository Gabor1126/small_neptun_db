DROP TABLE t_subject CASCADE CONSTRAINTS;

CREATE TABLE t_subject(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	name 				VARCHAR2(40) 		NOT NULL,
        code VARCHAR2(20) NOT NULL,
        specialization_id NUMBER,
        degrees_id NUMBER,
       	semester 			NUMBER 			NOT NULL,
	version 			NUMBER,
	dml_flag 			VARCHAR2(1),
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_subject_specialization FOREIGN KEY (specialization_id) REFERENCES t_specialization(id),
        CONSTRAINT fk_subject_degrees FOREIGN KEY (degrees_id) REFERENCES t_degrees(id)
) TABLESPACE neptun_tablespace;