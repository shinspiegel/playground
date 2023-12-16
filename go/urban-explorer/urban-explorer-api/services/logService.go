package services

import (
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
)

const (
	TRACE = 6
	DEBUG = 5
	ERROR = 4
	INFO  = 3
	WARN  = 2
	FATAL = 1
	PANIC = 0
)

const (
	green   = "\033[97;42m"
	white   = "\033[90;47m"
	yellow  = "\033[90;43m"
	red     = "\033[97;41m"
	blue    = "\033[97;44m"
	magenta = "\033[97;45m"
	cyan    = "\033[97;46m"
	reset   = "\033[0m"
)

type ILogService interface {
	Trace(message string, args ...any)
	Debug(message string, args ...any)
	Info(message string, args ...any)
	Warn(message string, args ...any)
	Error(message string, args ...any)
	Fatal(message string, args ...any)
	Panic(message string, args ...any)
}

type LogService struct {
	level uint8
}

func NewLogService() *LogService {
	logger := LogService{}
	logger.setLogLevel()
	logger.Trace("logger created")
	logger.Debug("log level", logger.level, os.Getenv("LOG_LEVEL"))

	return &logger
}

func (s *LogService) Trace(message string, args ...any) {
	if TRACE <= s.level {
		s.displayTerminal(
			"TRACE",
			message,
			args...,
		)
	}
}

func (s *LogService) Debug(message string, args ...any) {
	if DEBUG <= s.level {
		s.displayTerminal(
			"DEBUG",
			message,
			args...,
		)
	}
}

func (s *LogService) Info(message string, args ...any) {
	if INFO <= s.level {
		s.displayTerminal(
			blue+"INFO "+reset,
			message,
			args...,
		)
	}
}

func (s *LogService) Warn(message string, args ...any) {
	if WARN <= s.level {
		s.displayTerminal(
			yellow+"WARN "+reset,
			message,
			args...,
		)
	}
}

func (s *LogService) Error(message string, args ...any) {
	if ERROR <= s.level {
		s.displayTerminal(
			red+"ERROR"+reset,
			message,
			args...,
		)
	}
}

func (s *LogService) Fatal(message string, args ...any) {
	if 1 <= s.level {
		s.displayTerminal(
			red+"FATAL"+reset,
			message,
			args...,
		)
		log.Fatal(message, args)
	}
}

func (s *LogService) Panic(message string, args ...any) {
	if PANIC <= s.level {
		s.displayTerminal(
			red+"PANIC"+reset,
			message,
			args...,
		)
		log.Panic(message, args)
	}
}

func (s *LogService) LogRequest(method string, status int, uri string, latency time.Duration, originIp string, extra ...any) {
	if INFO <= s.level {
		s.displayRequestTerminal(method, status, uri, latency, originIp)
	}
	if TRACE <= s.level {
		s.displayRequestDataTerminal(extra...)
	}
}

func (s *LogService) LogMiddleware(ctx *gin.Context) {
	startTime := time.Now()

	ctx.Next()

	endTime := time.Now()
	latency := endTime.Sub(startTime)
	method := ctx.Request.Method
	uri := ctx.Request.RequestURI
	code := ctx.Writer.Status()
	clientIP := ctx.ClientIP()

	s.LogRequest(
		method,
		code,
		uri,
		latency,
		clientIP,

		*ctx.Request,
	)

	ctx.Next()
}

func (s *LogService) displayTerminal(level string, message string, args ...any) {
	t := time.Now()
	fmt.Printf(
		"%d-%02d-%02d %02d:%02d | %s | %-32s | %+v\n",

		t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(),
		level,
		message,
		args,
	)
}

func (s *LogService) displayRequestTerminal(method string, status int, uri string, latency time.Duration, clientIp string) {
	t := time.Now()
	fmt.Printf(
		"%d-%02d-%02d %02d:%02d | %-5s | %3d | %18s | %s | %s \n",

		t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(),
		method,
		status,
		uri,
		latency,
		clientIp,
	)
}

func (s *LogService) displayRequestDataTerminal(data ...any) {
	for _, d := range data {
		fmt.Printf("%+v \n", d)
	}
	fmt.Printf("\n")
}

func (s *LogService) setLogLevel() {
	level := os.Getenv("LOG_LEVEL")
	level = strings.ToLower(level)

	switch level {
	case "panic":
		s.level = PANIC

	case "fatal":
		s.level = FATAL

	case "error":
		s.level = ERROR

	case "warn":
		s.level = WARN

	case "info":
		s.level = INFO

	case "debug":
		s.level = DEBUG

	case "trace":
		s.level = TRACE

	default:
		log.Fatal("failed to read the LOG_LEVEL")
	}
}
