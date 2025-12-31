FROM pgxn/pgxn-tools

# install git and build tools for pgvector (pgxn-tools may not have them)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    postgresql-server-dev-17 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /srv
COPY . /srv

# build and install pgvector for PostgreSQL 17 (for testing)
# pgvector will be available when testing with PG 17
RUN cd /tmp && \
  git clone --branch v0.8.1 --depth 1 https://github.com/pgvector/pgvector.git && \
  cd pgvector && \
  make PG_CONFIG=/usr/lib/postgresql/17/bin/pg_config && \
  make install PG_CONFIG=/usr/lib/postgresql/17/bin/pg_config && \
  cd / && \
  rm -rf /tmp/pgvector
