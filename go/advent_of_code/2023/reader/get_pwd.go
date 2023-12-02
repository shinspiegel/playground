package reader

import (
	"log"
	"os"
)

func GetPwd() string {
	pwd, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	return pwd
}
