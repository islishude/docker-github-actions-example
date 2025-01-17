# syntax=docker/dockerfile:1
FROM golang:1.23-alpine as compiler
RUN apk add --no-cache make gcc musl-dev linux-headers git ca-certificates
WORKDIR /app
COPY . .
RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build go build -o simple-http-server .

FROM alpine:3.21
COPY --from=compiler /app/simple-http-server /usr/local/bin/
ENTRYPOINT [ "simple-http-server" ]
