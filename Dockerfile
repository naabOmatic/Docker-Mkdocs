FROM alpine:latest

LABEL maintainer="naabOmatic"

### Set group, user and port params
ARG GID="1000"
ARG UID="1000"

ARG GRP="mkdocs"
ARG USR="mkdocs"

ARG PORT="8000"

### Create user and group
RUN addgroup -g ${GID} -S ${GRP} \
  && adduser -u ${UID} -D -h /home/${USR} -G ${GRP} -s /sbin/nologin ${USR}

### Install apk and PyPI packages
RUN apk --no-cache update \
  && apk add --no-cache python3 \
  && pip3 install --upgrade pip \
    mkdocs

### Set working directory
WORKDIR /home/${USR}

### Create script for entrypoint
RUN echo 'exec mkdocs "$@"' > entrypoint.sh \
  && chmod +x entrypoint.sh \
  && chown ${USR}:${GRP} entrypoint.sh

### Make those parameters available outside the container
EXPOSE ${PORT}
VOLUME /home/${USR}

### Change user before running the container
USER ${USR}

#ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
ENTRYPOINT ["mkdocs"]
CMD ["serve"] #default arg when nothing passed to entrypoint
