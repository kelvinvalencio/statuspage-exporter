FROM golang:1.19 AS builder
ARG TARGETOS
ARG TARGETARCH
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /out/statuspage-exporter .

FROM gcr.io/distroless/static-debian11:nonroot
COPY --from=builder /out/statuspage-exporter /usr/local/bin/statuspage-exporter
ENTRYPOINT ["statuspage-exporter"]

