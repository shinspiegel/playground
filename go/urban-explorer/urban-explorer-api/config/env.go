package config

import (
	"log"

	"github.com/joho/godotenv"
)

func ReadEnv(envFile *string) {
	if envFile != nil && *envFile != "" {
		err := godotenv.Load(*envFile)
		if err != nil {
			log.Fatalf("Fail to load ['%v'] the environment.", envFile)
		}
	}
}
