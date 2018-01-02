SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE p_people IS

  ----------------------------------------------------------------------------------  
  -- Tanul� adatainak besz�r�sa
  PROCEDURE proc_insert_student(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_relationship IN	VARCHAR2,
                            p_end_of_relationship IN		VARCHAR2,
                            p_act_semester 	IN		NUMBER,
                            p_degrees_id 	IN NUMBER,
                            p_specialization_id 	IN		NUMBER,
                            p_active        IN        NUMBER);
  
  -- Tanul� adatainak m�dos��t�sa
  PROCEDURE proc_update_student(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_relationship IN	VARCHAR2,
                            p_end_of_relationship 	IN	VARCHAR2,
                            p_act_semester 	IN		NUMBER,
                            p_degrees_id 	IN NUMBER,
                            p_specialization_id 	IN		NUMBER,
                            p_active        IN        NUMBER,
                            p_neptun_code   IN VARCHAR2);
  
  -- Tanul� t�rl�se
  PROCEDURE proc_delete_student(p_neptun_code IN VARCHAR2);
  
  -- Tanul� akt�v�l�sa                          
  PROCEDURE proc_activate_student(p_neptun_code IN VARCHAR2);
  
  -- Tanul� passz�v�l�sa
  PROCEDURE proc_passivate_student(p_neptun_code IN VARCHAR2);

  ----------------------------------------------------------------------------------
  
  -- Tan�r adatainak besz�r�sa
  PROCEDURE proc_insert_teacher(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_work IN		VARCHAR2,
                            p_department_id IN          NUMBER);
                               
  -- Tan�r adatainak m�dos��t�sa
  PROCEDURE proc_update_teacher(p_first_name 	IN		VARCHAR2,
                            p_last_name 	IN		VARCHAR2,
                            p_birth_date 	IN		VARCHAR2,
                            p_birth_place_city 	IN	VARCHAR2,
                            p_loc_city 		IN	VARCHAR2,
                            p_loc_address 	IN		VARCHAR2,
                            p_email 		IN		VARCHAR2,
                            p_tel 			IN	VARCHAR2,
                            p_beggining_of_work IN		VARCHAR2,
                            p_department_id IN         NUMBER,
                            p_neptun_code   IN VARCHAR2);

----------------------------------------------------------------------------------
END p_people;