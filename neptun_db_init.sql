CREATE USER neptun_admin 
  IDENTIFIED BY "12345678" 
  DEFAULT TABLESPACE users
  QUOTA UNLIMITED ON users
;

GRANT CREATE SESSION TO neptun_admin;

CREATE TABLESPACE neptun_tablespace DATAFILE 'c:\oraclexe\app\oracle\oradata\XE\neptun_tablespace.dbf' SIZE 100M;

ALTER USER neptun_admin QUOTA UNLIMITED ON neptun_tablespace;

GRANT SELECT ON SYS.DBA_JOBS_RUNNING TO neptun_admin; 
GRANT CONNECT TO neptun_admin;
GRANT RESOURCE TO neptun_admin;
GRANT CREATE TABLE TO neptun_admin;
GRANT CREATE DATABASE LINK TO neptun_admin;
GRANT CREATE PROCEDURE TO neptun_admin;
GRANT CREATE SEQUENCE TO neptun_admin;
GRANT CREATE SESSION TO neptun_admin;
GRANT CREATE TRIGGER TO neptun_admin;
GRANT CREATE TYPE TO neptun_admin;
GRANT CREATE VIEW TO neptun_admin;

ALTER SESSION SET CURRENT_SCHEMA=neptun_admin;