# PRODUCTION alm code builder
FROM alpine as pflanzastic-prod-elm-builder

ARG uid
ARG uname
ARG gid
ARG gname

ENV uid ${uid:-1000}
ENV uname ${uname:-hector}
ENV gid ${gid:-1000}
ENV gname ${gname:-hector}
ENV homedir /home/${uname}

RUN apk --no-cache add shadow curl

RUN  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip elm.gz \
    && chmod +x elm \
    && mv elm /usr/local/bin/

RUN addgroup -g ${gid} ${gname} \
    && adduser -u ${uid} -g ${gid} -H -D ${uname} \
    && usermod -a -G root ${uname}

USER ${uname}

# DEVELOPMENT Continuous builder that watches the elm files changes 
# and recompiles the elm.js file

FROM alpine as pflanzastic-dev-elm-builder

ARG uid
ARG uname
ARG gid
ARG gname

ENV uid ${uid:-1000}
ENV uname ${uname:-hector}
ENV gid ${gid:-1000}
ENV gname ${gname:-hector}
ENV homedir /home/${uname}

RUN apk --no-cache add shadow curl npm

# ELM install
RUN  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip elm.gz \
    && chmod +x elm \
    && mv elm /usr/local/bin/

# Chokidar file watcher
RUN npm install chokidar-cli -g --save-dev

RUN addgroup -g ${gid} ${gname} \
    && adduser -u ${uid} -H -G ${gname} -D ${uname} \
    && usermod -a -G www-data,root ${uname}

# Default user
USER ${uname}