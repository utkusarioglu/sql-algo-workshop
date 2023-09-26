CREATE ROLE "rs_experimenter"
  NOCREATEDB
  NOCREATEROLE
  LOGIN
  IN GROUP
    "gs_experimenter"
  ENCRYPTED PASSWORD
   'gs_experimenter_password'
  CONNECTION LIMIT 10;
