CREATE OR REPLACE TRIGGER degrees_on_insert
  BEFORE INSERT ON t_degrees
  FOR EACH ROW
BEGIN
  SELECT degrees_seq.nextval
  INTO :new.id
  FROM dual;
END;
