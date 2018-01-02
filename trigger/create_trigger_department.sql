CREATE OR REPLACE TRIGGER department_on_insert
  BEFORE INSERT ON t_department
  FOR EACH ROW
BEGIN
  SELECT department_seq.nextval
  INTO :new.id
  FROM dual;
END;