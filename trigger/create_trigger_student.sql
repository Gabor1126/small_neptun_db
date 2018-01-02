CREATE OR REPLACE TRIGGER student_on_insert
  BEFORE INSERT ON t_student
  FOR EACH ROW
BEGIN
  SELECT student_seq.nextval
  INTO :new.id
  FROM dual;
END;