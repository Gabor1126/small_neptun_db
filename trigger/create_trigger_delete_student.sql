CREATE OR REPLACE TRIGGER delete_student
BEFORE DELETE
   ON t_student
   FOR EACH ROW

BEGIN
   INSERT INTO t_student_history
   (    id,
       	first_name,
       	last_name,
       	birth_date,
       	birth_place_city,
       	loc_city,
       	loc_address,
       	email,
       	tel,
       	beggining_of_relationship,
       	end_of_relationship,
       	act_semester,
        degrees_id,
       	specialization_id,
        neptun_code,
	version,
	dml_flag,
       	created_date,
        modified_by )
   VALUES
   ( :old.id,
       	:old.first_name,
       	:old.last_name,
       	:old.birth_date,
       	:old.birth_place_city,
       	:old.loc_city,
       	:old.loc_address,
       	:old.email,
       	:old.tel,
       	:old.beggining_of_relationship,
       	:old.end_of_relationship,
       	:old.act_semester,
        :old.degrees_id,
       	:old.specialization_id,
        :old.neptun_code,
	:old.version,
	'D',
      sysdate,
      user );

END;