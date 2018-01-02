SET SQLBLANKLINES ON
CREATE OR REPLACE PACKAGE p_organization IS

  ----------------------------------------------------------------------------------  
  -- Int�zet n�v besz�r�sa
  PROCEDURE proc_insert_institution(p_name IN VARCHAR2,
                                p_short_name IN VARCHAR2);
  
  -- Int�zet m�dos�t�sa
  PROCEDURE proc_update_institution(p_id IN NUMBER,
                                p_name 	IN VARCHAR2,
                                p_short_name IN VARCHAR2);


  ----------------------------------------------------------------------------------
  
  -- Tansz�k besz�r�sa
  PROCEDURE proc_insert_department(p_name IN VARCHAR2,
                               p_short_name IN VARCHAR2,
                               p_insitution_id  IN NUMBER);
                               
  -- Tansz�k m�dos��sa
  PROCEDURE proc_update_department(p_id IN NUMBER,
                                p_name IN VARCHAR2,
                                p_short_name IN VARCHAR2,
                               p_insitution_id IN  NUMBER);
                               

----------------------------------------------------------------------------------
END p_organization;
/