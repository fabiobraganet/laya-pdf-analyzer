FROM rust:1.88-bookworm AS build
WORKDIR /app
COPY Cargo.toml Cargo.toml
COPY src src
COPY static static
RUN cargo test --release
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl poppler-utils && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=build /app/target/release/laya-pdf-analyzer /usr/local/bin/laya-pdf-analyzer
COPY static static
ENV APP_HOST=0.0.0.0 APP_PORT=8082 APP_DATABASE_URL=/data/laya-pdf-analyzer.db
VOLUME ["/data"]
EXPOSE 8082
CMD ["laya-pdf-analyzer"]
