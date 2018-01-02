CREATE OR REPLACE TRIGGER institution_on_insert
  BEFORE INSERT ON t_institution
  FOR EACH ROW
BEGIN
  SELECT institution_seq.nextval
  INTO :new.id
  FROM dual;
END;