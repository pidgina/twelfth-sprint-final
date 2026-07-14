FROM golang:1.26.4 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o my_app .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/my_app .
COPY tracker.db .

CMD ["./my_app"] 

