FROM nginx:1.19-alpine as pflanzastic-client-elm

# PRODUCTION elm code builder
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

RUN groupadd -g ${gid} ${gname}
# RUN cat /etc/passwd
RUN useradd -u ${uid} -g ${gid} -M ${uname}
RUN usermod -a -G root ${uname}

USER ${uname}


# DEVELOPMENT Continuous builder that watches the elm files changes 
# and recompiles the elm.js file

FROM pflanzastic-prod-elm-builder as pflanzastic-dev-elm-builder

USER root
RUN apk --no-cache add npm
RUN npm install chokidar-cli -g --save-dev

ENV SHELL /bin/sh

USER ${uname}