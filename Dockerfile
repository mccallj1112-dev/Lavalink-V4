# ─────────────────────────────────────────────────────────────────
#  Dark Lavalink V4 — Dockerfile
#  © 2025 Dark (SynthX Development) — github.com/SynthXDev/dark-lavalink
# ─────────────────────────────────────────────────────────────────

FROM eclipse-temurin:21-jre-alpine

LABEL maintainer="Dark <SynthX Development>"
LABEL description="Lavalink V4 — Premium Node by Dark"

# Hard-coded to 2333 — set PORT=2333 in Railway Variables
ENV LAVALINK_VERSION=4.0.8
ENV SERVER_PORT=2333
ENV PORT=2333
ENV JAVA_OPTS="-Xmx512m -Xms128m -XX:+UseG1GC -Dfile.encoding=UTF-8"

RUN addgroup -S lavalink && adduser -S lavalink -G lavalink

WORKDIR /app

ADD https://github.com/lavalink-devs/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar ./Lavalink.jar

COPY application.yml ./application.yml

RUN mkdir -p /app/logs && chown -R lavalink:lavalink /app

USER lavalink

EXPOSE 2333

# Pass port three ways so Spring Boot definitely picks it up
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=2333 -jar Lavalink.jar"]
