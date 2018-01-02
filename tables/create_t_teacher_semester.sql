DROP TABLE t_teacher_semester CASCADE CONSTRAINTS;

CREATE TABLE t_teacher_semester(
       	id 				NUMBER 			NOT NULL PRIMARY KEY,
       	teacher_id 				NUMBER 		NOT NULL,
        subject_id      NUMBER 		NOT NULL,
	year VARCHAR2(9) NOT NULL,
        semester NUMBER NOT NULL,
       	created_date			DATE			DEFAULT SYSDATE NOT NULL,
        modified_by     VARCHAR2(255),
        CONSTRAINT fk_teacher_sem_teacher FOREIGN KEY (teacher_id) REFERENCES t_teacher(id),
        CONSTRAINT fk_teacher_sem_subject FOREIGN KEY (subject_id) REFERENCES t_subject(id),
	CONSTRAINT check_teacher_semester CHECK (semester BETWEEN 1 and 2)
) TABLESPACE neptun_tablespace;