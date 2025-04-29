
\i '/assets/migrations/groups.static.create.sql'
\i '/assets/migrations/roles.static.create.sql'

-- Skipping tablespace creation due to lack of initcontainers in docker
-- \i '/assets/migrations/tablespaces.create.sql'

\i '/assets/migrations/databases.create.sql'
\c experiments

-- \i '/assets/migrations/experiments.tables.create.sql'

\i '/assets/migrations/gs_experimenter.permissions.create.sql'
