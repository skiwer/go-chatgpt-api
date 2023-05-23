FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build -ldflags="-w -s" -o go-chatgpt-api main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/go-chatgpt-api .
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
EXPOSE $PORT
CMD ["/app/go-chatgpt-api"]
