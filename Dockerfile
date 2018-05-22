FROM alpine:latest

LABEL maintainer="naabOmatic"

ARG GID="1493"
ARG UID="1493"

ARG GRP="mkdocs"
ARG USR="mkdocs"


### Create user and group
RUN addgroup -g ${GID} -S ${GRP} \
  #&& adduser -u ${UID} -D -H -S -G ${GRP} -s /sbin/nologin ${USR}
  && adduser -u ${UID} -D -h /home/${USR} -G ${GRP} -s /sbin/nologin ${USR}

### Install packages
RUN apk --no-cache update \
  && apk add --no-cache python3 \
  #Pipy packages
  && pip3 install --upgrade pip \
    mkdocs

#RUN echo 'exec mkdocs "$@"' > entrypoint.sh \
#  && chmod +x entrypoint.sh \
#  && chown ${USR}:${GRP} entrypoint.sh

WORKDIR /home/${USR}

RUN echo 'exec mkdocs "$@"' > entrypoint.sh \
  && chmod +x entrypoint.sh \
  && chown ${USR}:${GRP} entrypoint.sh

EXPOSE 8000
VOLUME /home/${USR}

#USER ${USR}


#ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
ENTRYPOINT ["mkdocs"]
CMD ["serve"]


