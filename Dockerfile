# ─────────────────────────────────────────────────────────────────
#  Dark Lavalink V4 — Dockerfile
#  Optimized for Railway.app deployment
#  © 2025 Dark (SynthX Development) — github.com/SynthXDev/dark-lavalink
# ─────────────────────────────────────────────────────────────────

# Use Eclipse Temurin JDK 21 (LTS) — Lavalink V4 requires Java 17+
# Alpine variant = smaller image = faster Railway deploys
FROM eclipse-temurin:21-jre-alpine

# ── Labels ──────────────────────────────────────────────────────
LABEL maintainer="Dark <SynthX Development>"
LABEL description="Lavalink V4 — Premium Node by Dark"
LABEL version="4.0.8"

# ── Env defaults (overridden by Railway environment variables) ───
ENV LAVALINK_VERSION=4.0.8
ENV JAVA_OPTS="-Xmx512m -Xms128m -XX:+UseG1GC -XX:+UseStringDeduplication -XX:+OptimizeStringConcat -Dfile.encoding=UTF-8"

# ── Create a non-root user for security ─────────────────────────
RUN addgroup -S lavalink && adduser -S lavalink -G lavalink

# ── App directory ────────────────────────────────────────────────
WORKDIR /app

# ── Download Lavalink jar from official GitHub releases ─────────
ADD https://github.com/lavalink-devs/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar ./Lavalink.jar

# ── Copy config ─────────────────────────────────────────────────
COPY application.yml ./application.yml

# ── Create logs directory ────────────────────────────────────────
RUN mkdir -p /app/logs && chown -R lavalink:lavalink /app

# ── Switch to non-root ────────────────────────────────────────────
USER lavalink

EXPOSE 2333

# ── Start Lavalink ───────────────────────────────────────────────
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar Lavalink.jar"]
