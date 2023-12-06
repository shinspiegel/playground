package reader

import (
	"log"
	"os"
)

func GetDay1() *string {
	return GetFromFile("day1/input")
}

func GetDay2() *string {
	return GetFromFile("day2/input")
}

func GetDay3() *string {
	return GetFromFile("day3/input")
}

func GetDay4() *string {
	return GetFromFile("day4/input")
}

func GetFromFile(path string) *string {
	bytes, err := os.ReadFile(path)
	if err != nil {
		log.Panic(err)
	}

	data := string(bytes)

	return &data
}
