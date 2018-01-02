CREATE OR REPLACE TRIGGER teacher_on_insert
  BEFORE INSERT ON t_teacher
  FOR EACH ROW
BEGIN
  SELECT teacher_seq.nextval
  INTO :new.id
  FROM dual;
END;