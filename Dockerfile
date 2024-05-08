FROM golang:alpine as builder
WORKDIR /build
COPY main.go .
COPY go.mod .
COPY go.sum .
RUN CGO_ENABLED=0 go build -o /go/bin/authservice main.go

FROM scratch
WORKDIR /
COPY html /html
COPY --from=builder /go/bin/authservice /authservice
ENTRYPOINT ["/authservice"]
