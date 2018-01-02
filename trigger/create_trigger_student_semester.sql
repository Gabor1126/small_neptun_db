CREATE OR REPLACE TRIGGER student_semester_on_insert
  BEFORE INSERT ON t_student_semester
  FOR EACH ROW
BEGIN
  SELECT student_semester_seq.nextval
  INTO :new.id
  FROM dual;
END;