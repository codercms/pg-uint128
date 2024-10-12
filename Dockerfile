ARG PGVERSION="15"

FROM debian:bookworm-20240926-slim AS builder

ARG PGVERSION
ENV PGVERSION=${PGVERSION}
ENV DEBIAN_FRONTEND=noninteractive

COPY . build/

WORKDIR /build

RUN apt-get update && apt-get install -y curl lsb-release

# Add PostgreSQL repository
RUN mkdir -p /usr/share/postgresql-common/pgdg && \
    (curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc) && \
    (echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list)

# Install PostgreSQL dev packages
RUN apt-get update && apt-get -y --no-install-recommends install gcc make postgresql-server-dev-$PGVERSION

# Verify pg_config command exist
RUN pg_config

# Build and install
RUN make clean && make && make install

# Build final image
FROM postgres:${PGVERSION}-bookworm

ARG PGVERSION
ENV UINT128_VERSION=1.0.0

COPY --from=builder /usr/lib/postgresql/$PGVERSION/lib/uint128.so           /usr/lib/postgresql/$PGVERSION/lib/uint128.so
COPY --from=builder /usr/share/postgresql/$PGVERSION/extension/uint128*     /usr/share/postgresql/$PGVERSION/extension
COPY --from=builder /usr/lib/postgresql/$PGVERSION/lib/bitcode/uint128      /usr/lib/postgresql/$PGVERSION/lib/bitcode/uint128

RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./docker/initdb-uint128.sh /docker-entrypoint-initdb.d/10_uint128.sh
COPY ./docker/update-uint128.sh /usr/local/bin
