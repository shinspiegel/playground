package day1

import (
	"log"
	"strconv"
	"strings"
	"unicode"
)

func PartOne(data *string) int64 {
	lines := strings.Split(*data, "\n")
	values := []int8{}
	sum := int64(0)

	for _, line := range lines {
		runes := []rune(line)

		var left *rune = nil
		var right *rune = nil

		for i := 0; i < len(runes); i++ {
			if left == nil && unicode.IsDigit((runes[i])) {
				val := runes[i]
				left = &val
			}
		}

		for i := len(runes) - 1; i >= 0; i-- {
			if right == nil && unicode.IsDigit((runes[i])) {
				val := runes[i]
				right = &val
			}
		}

		number, err := strconv.ParseInt(string(*left)+string(*right), 10, 8)
		if err != nil {
			log.Panic(err)
		}
		values = append(values, int8(number))
	}

	for _, val := range values {
		sum += int64(val)
	}

	return sum
}
