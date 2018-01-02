DROP TABLE t_student_semester CASCADE CONSTRAINTS;

CREATE TABLE t_student_semester(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	student_id 				NUMBER 		NOT NULL,
        subject_id      NUMBER 		NOT NULL,
	teacher_id      NUMBER 		NOT NULL,
	year VARCHAR2(9) NOT NULL,
        semester NUMBER NOT NULL,
        grade NUMBER NOT NULL, 
       	created_date			DATE			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_student_sem_student FOREIGN KEY (student_id) REFERENCES t_student(id),
        CONSTRAINT fk_student_sem_subject FOREIGN KEY (subject_id) REFERENCES t_subject(id),
	CONSTRAINT check_student_semester CHECK (semester BETWEEN 1 and 2),
	CONSTRAINT check_student_grade CHECK (grade BETWEEN 1 and 5)
) TABLESPACE neptun_tablespace;