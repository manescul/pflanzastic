FROM alpine as prod-client-builder

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