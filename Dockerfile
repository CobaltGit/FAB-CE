FROM mhart/alpine-node:12 AS builder

RUN mkdir -p /usr/src/fab
WORKDIR /usr/src/fab

COPY / /usr/src/fab 

RUN yarn

FROM mhart/alpine-node:slim-12 AS runner

COPY --from=builder /usr/src/fab /usr/src/fab

WORKDIR /usr/src/fab

RUN apk add gettext --no-cache

ENTRYPOINT /bin/sh -c "envsubst '\$TOKEN' < /usr/src/fab/data/settings.json > /usr/src/fab/data/settings-postenv.json && \
    rm /usr/src/fab/data/settings.json && \
    mv /usr/src/fab/data/settings-postenv.json /usr/src/fab/data/settings.json && \
    node bot.js"