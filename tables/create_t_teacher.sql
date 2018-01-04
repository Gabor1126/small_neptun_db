DROP TABLE t_teacher CASCADE CONSTRAINTS;

CREATE TABLE t_teacher(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	first_name 			VARCHAR2(40) 		NOT NULL,
       	last_name 			VARCHAR2(40) 		NOT NULL,
       	birth_date 			DATE,
       	birth_place_city 		VARCHAR2(50),
       	loc_city 			VARCHAR2(100),
       	loc_address 			VARCHAR2(100),
       	email 				VARCHAR2(100),
       	tel 				VARCHAR2(20),
       	beggining_of_work 		DATE,
        neptun_code  VARCHAR2(6) UNIQUE,
        department_id           NUMBER NOT NULL,
	version 		NUMBER,
	dml_flag 		VARCHAR2(1),
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_teacher_department FOREIGN KEY (department_id) REFERENCES t_department(id)
) TABLESPACE neptun_tablespace;