CREATE OR REPLACE TRIGGER specialization_on_insert
  BEFORE INSERT ON t_specialization
  FOR EACH ROW
BEGIN
  SELECT specialization_seq.nextval
  INTO :new.id
  FROM dual;
END;