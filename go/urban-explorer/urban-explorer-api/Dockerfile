FROM golang:alpine as builder
RUN apk add --no-cache make
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN make build


FROM alpine
RUN apk add --no-cache make
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /app/bin /app/bin
WORKDIR /app
CMD ["./urban-explorer"]