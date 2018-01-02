SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE p_organization IS

  ----------------------------------------------------------------------------------  
  -- Intézet név beszúrása
  PROCEDURE proc_insert_institution(p_name IN VARCHAR2,
                                p_short_name IN VARCHAR2);
  
  -- Intézet módosítása
  PROCEDURE proc_update_institution(p_id IN NUMBER,
                                p_name 	IN VARCHAR2,
                                p_short_name IN VARCHAR2);


  ----------------------------------------------------------------------------------
  
  -- Tanszék beszúrása
  PROCEDURE proc_insert_department(p_name IN VARCHAR2,
                               p_short_name IN VARCHAR2,
                               p_insitution_id  IN NUMBER);
                               
  -- Tanszék módosíása
  PROCEDURE proc_update_department(p_id IN NUMBER,
                                p_name IN VARCHAR2,
                                p_short_name IN VARCHAR2,
                               p_insitution_id IN  NUMBER);
                               

----------------------------------------------------------------------------------
END p_organization;
/