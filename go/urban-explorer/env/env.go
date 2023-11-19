package env

import (
	"flag"
	"log"

	"github.com/joho/godotenv"
)

func ReadEnv() {
	envPath := flag.String("env", "", "Path to the .env file")
	flag.Parse()

	if *envPath != "" {
		err := godotenv.Load(*envPath)
		if err != nil {
			log.Fatalf("Fail to load ['%v'] the environment.", *envPath)
		}
	}
}
