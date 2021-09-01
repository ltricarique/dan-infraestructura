FROM postgres:13.2-alpine
COPY scripts/dan-ms.dump .
COPY scripts/init-db.sh /docker-entrypoint-initdb.d/