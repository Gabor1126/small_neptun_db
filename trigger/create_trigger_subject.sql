CREATE OR REPLACE TRIGGER subject_on_insert
  BEFORE INSERT ON t_subject
  FOR EACH ROW
BEGIN
  SELECT subject_seq.nextval
  INTO :new.id
  FROM dual;
END;