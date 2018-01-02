CREATE OR REPLACE TRIGGER teacher_semester_on_insert
  BEFORE INSERT ON t_teacher_semester
  FOR EACH ROW
BEGIN
  SELECT teacher_semester_seq.nextval
  INTO :new.id
  FROM dual;
END;
