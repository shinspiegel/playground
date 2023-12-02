package day2

import (
	"log"
	"strconv"
	"strings"
)

type Cube struct {
	Red   int64
	Green int64
	Blue  int64
}

func NewCubes(games []string) []Cube {
	cubes := []Cube{}
	for _, game := range games {
		cube := NewCube(&game)
		cubes = append(cubes, *cube)
	}
	return cubes
}

func NewCube(game *string) *Cube {
	parts := strings.Split(*game, ", ")
	cube := &Cube{}

	for _, part := range parts {
		innerData := strings.Split(part, " ")

		if strings.Contains(innerData[1], "blue") {
			val, err := strconv.ParseInt(innerData[0], 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			cube.Blue = val
		}

		if strings.Contains(innerData[1], "green") {
			val, err := strconv.ParseInt(innerData[0], 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			cube.Green = val
		}

		if strings.Contains(innerData[1], "red") {
			val, err := strconv.ParseInt(innerData[0], 10, 64)
			if err != nil {
				log.Fatal(err)
			}
			cube.Red = val
		}
	}

	return cube
}

func IsGameValid(total *Cube, games []Cube) bool {
	for _, game := range games {
		if game.Blue > total.Blue ||
			game.Green > total.Green ||
			game.Red > total.Red {
			return false
		}
	}
	return true
}

func PartOne(data *string, total *Cube) int64 {
	lines := strings.Split(*data, "\n")
	sum := int64(0)

	for _, line := range lines {
		split := strings.Split(line, ": ")
		gameNumber, err := strconv.ParseInt(strings.Split(split[0], " ")[1], 10, 64)
		if err != nil {
			log.Panic(err)
		}

		gameData := NewCubes(strings.Split(split[1], "; "))

		if IsGameValid(total, gameData) {
			sum += gameNumber
		}
	}

	return sum
}

func PartTwo() {}
