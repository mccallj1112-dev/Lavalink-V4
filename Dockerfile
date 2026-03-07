# ─────────────────────────────────────────────────────────────────
#  Dark Lavalink V4 — Dockerfile
#  Optimized for Railway.app deployment
#  © 2025 Dark (SynthX Development) — github.com/SynthXDev/dark-lavalink
# ─────────────────────────────────────────────────────────────────

FROM eclipse-temurin:21-jre-alpine

LABEL maintainer="Dark <SynthX Development>"
LABEL description="Lavalink V4 — Premium Node by Dark"

ENV LAVALINK_VERSION=4.0.8
ENV JAVA_OPTS="-Xmx512m -Xms128m -XX:+UseG1GC -Dfile.encoding=UTF-8"

RUN addgroup -S lavalink && adduser -S lavalink -G lavalink

WORKDIR /app

ADD https://github.com/lavalink-devs/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar ./Lavalink.jar

COPY application.yml ./application.yml

RUN mkdir -p /app/logs && chown -R lavalink:lavalink /app

USER lavalink

EXPOSE 2333

# KEY FIX: Pass $PORT directly as a JVM system property so Spring Boot
# binds to whatever port Railway assigns — not just the yml default
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-2333} -jar Lavalink.jar"]
