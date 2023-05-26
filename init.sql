-- init.sql
CREATE DATABASE myapp_development;
CREATE USER postgres WITH ENCRYPTED PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE myapp_development TO postgres;
