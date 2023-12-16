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
		s.display(s.formatMessage("TRACE", message, args...))
		s.writeToFile(s.formatMessage("TRACE", message, args...))
	}
}

func (s *LogService) Debug(message string, args ...any) {
	if DEBUG <= s.level {
		s.display(s.formatMessage("DEBUG", message, args...))
		s.writeToFile(s.formatMessage("DEBUG", message, args...))
	}
}

func (s *LogService) Info(message string, args ...any) {
	if INFO <= s.level {
		s.display(s.formatMessage(blue+"INFO"+reset, message, args...))
		s.writeToFile(s.formatMessage("INFO", message, args...))
	}
}

func (s *LogService) Warn(message string, args ...any) {
	if WARN <= s.level {
		s.display(s.formatMessage(yellow+"WARN"+reset, message, args...))
		s.writeToFile(s.formatMessage("WARN", message, args...))
	}
}

func (s *LogService) Error(message string, args ...any) {
	if ERROR <= s.level {
		s.display(s.formatMessage(red+"ERROR"+reset, message, args...))
		s.writeToFile(s.formatMessage("ERROR", message, args...))
	}
}

func (s *LogService) Fatal(message string, args ...any) {
	if 1 <= s.level {
		s.display(s.formatMessage(red+"FATAL"+reset, message, args...))
		s.writeToFile(s.formatMessage("FATAL", message, args...))
		log.Fatal(message, args)
	}
}

func (s *LogService) Panic(message string, args ...any) {
	if PANIC <= s.level {
		s.display(s.formatMessage(red+"PANIC"+reset, message, args...))
		s.writeToFile(s.formatMessage("PANIC", message, args...))
		log.Panic(message, args)
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
	codeTerminal := fmt.Sprint(code)
	clientIP := ctx.ClientIP()

	if code < 200 {
		codeTerminal = cyan + codeTerminal + reset
	}
	if code < 300 {
		codeTerminal = green + codeTerminal + reset
	}
	if code < 400 {
		codeTerminal = cyan + codeTerminal + reset
	}
	if code < 500 {
		codeTerminal = magenta + codeTerminal + reset
	}
	if code < 600 {
		codeTerminal = red + codeTerminal + reset
	}

	if INFO <= s.level {
		s.display(s.formatRequest(method, codeTerminal, uri, latency, clientIP))
		s.writeToFile(s.formatRequest(method, fmt.Sprint(code), uri, latency, clientIP))
	}

	if TRACE <= s.level {
		s.display(fmt.Sprintf("%+v\n", ctx.Request))
		s.writeToFile(fmt.Sprintf("%+v\n", ctx.Request))
	}

	ctx.Next()
}

func (s *LogService) formatMessage(level string, message string, args ...any) string {
	t := time.Now()
	return fmt.Sprintf(
		"%d-%02d-%02d %02d:%02d | %-5s | %-50s | %+v\n",

		t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(),
		level,
		message,
		args,
	)
}

func (s *LogService) formatRequest(method string, status string, uri string, latency time.Duration, clientIp string) string {
	t := time.Now()

	return fmt.Sprintf(
		"%d-%02d-%02d %02d:%02d | %-5s | %-7s | %-40s | %8s | %s \n",

		t.Year(), t.Month(), t.Day(), t.Hour(), t.Minute(),
		status,
		method,
		uri,
		latency,
		clientIp,
	)
}

func (s *LogService) writeToFile(message string) {
	file, err := os.OpenFile("dev.log", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)

	if err != nil {
		if ERROR <= s.level {
			s.display(s.formatMessage("ERROR", err.Error()))
		}
	}

	defer file.Close()

	if _, err := file.WriteString(message); err != nil {
		if ERROR <= s.level {
			s.display(s.formatMessage("ERROR", err.Error()))
		}
	}
}

func (s *LogService) display(message string) {
	fmt.Print(message)
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
