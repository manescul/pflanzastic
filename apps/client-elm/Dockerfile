# PRODUCTION alm code builder
FROM alpine as prod-elm-builder

ARG uname
ARG uid

ENV ugname ${uname:-hector}
ENV ugid ${uid:-1000}

RUN apk --no-cache add shadow curl

RUN  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip elm.gz \
    && chmod +x elm \
    && mv elm /usr/local/bin/

RUN addgroup -g ${ugid} ${ugname} \
    && adduser -u ${ugid} -G ${ugname} -HD ${ugname} \
    && usermod -a -G root ${ugname}

USER ${ugname}

# DEVELOPMENT Continuous builder that watches the elm files changes 
# and recompiles the elm.js file

FROM alpine as dev-elm-builder

ARG uname
ARG uid

ENV ugname ${uname:-hector}
ENV ugid ${uid:-1000}
ENV homedir /home/${ugname}

RUN apk --no-cache add shadow curl npm

RUN addgroup -g ${ugid} ${ugname} \
    && adduser -u ${ugid} -h ${homedir} -G ${ugname} -D ${ugname} \
    && usermod -a -G www-data,root ${ugname} \
    && mkdir -p ${homedir} \
    && chown -R ${ugname}:${ugname} ${homedir}

# ELM install
RUN  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip elm.gz \
    && chmod +x elm \
    && mv elm /usr/local/bin/

# Chokidar file watcher
RUN npm install chokidar-cli -g --save-dev

# Default user
USER ${ugname}