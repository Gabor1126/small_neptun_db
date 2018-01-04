DROP TABLE t_student CASCADE CONSTRAINTS;

CREATE TABLE t_student(
       	id 				NUMBER NOT NULL 	PRIMARY KEY,
       	first_name 			VARCHAR2(40) 		NOT NULL,
       	last_name 			VARCHAR2(40) 		NOT NULL,
       	birth_date 			DATE,
       	birth_place_city 		VARCHAR2(50),
       	loc_city 			VARCHAR2(100),
       	loc_address 			VARCHAR2(100),
       	email 				VARCHAR2(100),
       	tel 				VARCHAR2(20),
       	beggining_of_relationship 	DATE,
       	end_of_relationship 		DATE,
       	act_semester 			NUMBER,
       	degrees_id 	NUMBER,
       	specialization_id 			NUMBER,
        neptun_code  VARCHAR2(6) UNIQUE,
        active                NUMBER(1),
	version 		NUMBER,
	dml_flag 		VARCHAR2(1),
       	created_date			DATE 			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_student_degrees FOREIGN KEY (degrees_id) REFERENCES t_degrees(id),
        CONSTRAINT fk_student_specialization FOREIGN KEY (specialization_id) REFERENCES t_specialization(id)
) TABLESPACE neptun_tablespace; 