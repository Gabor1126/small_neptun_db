DROP TABLE t_degrees CASCADE CONSTRAINTS;

CREATE TABLE t_degrees(
      	id 				NUMBER 			NOT NULL PRIMARY KEY,
      	name 				VARCHAR2(80) 		NOT NULL,
        traning_level 			VARCHAR(5) 		NOT NULL,
        department_id    NUMBER NOT NULL,
        created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_degrees_department FOREIGN KEY (department_id) REFERENCES t_department(id)
) TABLESPACE neptun_tablespace; 