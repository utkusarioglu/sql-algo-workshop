
\i '/migrations/groups.static.create.sql'
\i '/migrations/roles.static.create.sql'

-- Skipping tablespace creation due to lack of initcontainers in docker
-- \i '/migrations/tablespaces.create.sql'

\i '/migrations/databases.create.sql'
\c experiments

-- \i '/migrations/experiments.tables.create.sql'

\i '/migrations/gs_experimenter.permissions.create.sql'
