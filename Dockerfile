FROM mhart/alpine-node:12 AS builder

RUN mkdir -p /usr/src/fab
WORKDIR /usr/src/fab

COPY / /usr/src/fab 

RUN yarn

FROM mhart/alpine-node:slim-12 AS runner

COPY --from=builder /usr/src/fab /usr/src/fab
COPY src/entrypoint.sh /usr/src/fab/

WORKDIR /usr/src/fab

RUN apk add gettext --no-cache && \
    chmod +x /usr/src/fab/entrypoint.sh
ENTRYPOINT [ "/usr/src/fab/entrypoint.sh" ]
