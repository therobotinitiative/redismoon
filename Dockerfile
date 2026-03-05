FROM redis:8.4.0-bookworm

ARG UID
ARG GID

USER root
# Match host user UID:GID (1000:1000 is typical)
RUN if [ -n "$UID" ] && [ -n "$GID" ]; then \
    usermod -u "$UID" redis && \
    groupmod -g "$GID" redis; \
    fi

USER redis
EXPOSE 6379
