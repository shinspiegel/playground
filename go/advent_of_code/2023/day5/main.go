package day5

import (
	"errors"
	"fmt"
	"log"
	"strconv"
	"strings"
	"unicode"
)

type Mappers struct {
	Origin        string
	Target        string
	DirectionList []Directions
}

type Directions struct {
	Target     int64
	Amount     int64
	StartValue int64
	EndValue   int64
}

func (m *Mappers) GetTarget(val int64) (string, int64, error) {
	for _, dir := range m.DirectionList {
		if val > dir.StartValue && val < dir.EndValue {

		}
	}

	return "", int64(0), nil
}

func findMapperByOrigin(list []Mappers, origin string) (*Mappers, error) {
	for _, m := range list {
		if m.Origin == origin {
			return &m, nil
		}
	}
	return nil, errors.New("Failed to find")
}

func parseData(data *string) (seeds []int64, mappers []Mappers) {
	lines := strings.Split(*data, "\n")
	seeds = []int64{}
	mappers = []Mappers{}
	mapper := Mappers{}

	for index, line := range lines {
		if index == 0 {
			// Get the seeds
			cleaned := strings.ReplaceAll(line, "seeds: ", "")
			numbersStr := strings.Split(cleaned, " ")

			for _, num := range numbersStr {
				seed, err := strconv.ParseInt(num, 10, 64)
				if err != nil {
					log.Fatal(err)
				}
				seeds = append(seeds, seed)
			}
			continue
		}

		// Skip empty line
		if index == 1 {
			continue
		}

		// Parse remaining data
		if line == "" {
			list = append(list, mapper)
			mapper = Mappers{}
			continue
		}

		// Parse origin -> target
		if !unicode.IsDigit(rune(line[0])) {
			cleaned := strings.ReplaceAll(line, " map:", "")
			directions := strings.Split(cleaned, "-")
			mapper.Origin = directions[0]
			mapper.Target = directions[2]
		}

		// Parse directions
		if unicode.IsDigit(rune(line[0])) {
			numbersStr := strings.Split(line, " ")
			numbers := []int64{}

			for _, num := range numbersStr {
				val, err := strconv.ParseInt(num, 10, 64)
				if err != nil {
					log.Fatal(err)
				}
				numbers = append(numbers, val)
			}

			dir := Directions{}
			dir.Target = numbers[0]
			dir.StartValue = numbers[1]
			dir.Amount = numbers[2]
			dir.EndValue = numbers[1] + (numbers[2] - 1)

			mapper.DirectionList = append(mapper.DirectionList, dir)
		}

		// There is no empty line in the end to trigger the routine to append
		if index == len(lines)-1 {
			list = append(list, mapper)
		}
	}

	return seeds, list
}

func PartOne(data *string) int64 {
	sum := int64(0)
	seeds, mappers := parseData(data)

	for _, seed := range seeds {
		var mp *Mappers

		for true {
			if mp == nil {
				m, err := findMapperByOrigin(mappers, "seed")
				if err != nil {
					log.Fatal(err)
				}
				mp = m
			}

			target, value, err := mp.GetTarget(seed)
		}
	}

	fmt.Print(seeds, mappers)

	return sum
}

func PartTwo(data *string) int64 {
	sum := int64(0)
	return sum
}
