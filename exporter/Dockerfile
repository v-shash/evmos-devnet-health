FROM alpine:3.16.0 AS prepare-env

RUN apk add wget

WORKDIR /tmp

RUN wget -c https://github.com/solarlabsteam/cosmos-exporter/releases/download/v0.3.0/cosmos-exporter_0.3.0_Linux_x86_64.tar.gz -O - | tar -xz

FROM alpine:3.16.0

WORKDIR /

COPY --from=prepare-env /tmp/cosmos-exporter /usr/bin/cosmos-exporter

COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]

