package day1

import (
	"log"
	"strconv"
	"strings"
	"unicode"
)

var (
	ONE   = "one"
	TWO   = "two"
	SIX   = "six"
	FOUR  = "four"
	FIVE  = "five"
	NINE  = "nine"
	THREE = "three"
	SEVEN = "seven"
	EIGHT = "eight"

	DIGIT_ONE   = "1"
	DIGIT_TWO   = "2"
	DIGIT_THREE = "3"
	DIGIT_FOUR  = "4"
	DIGIT_FIVE  = "5"
	DIGIT_SIX   = "6"
	DIGIT_SEVEN = "7"
	DIGIT_EIGHT = "8"
	DIGIT_NINE  = "9"
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

func PartTwo(data *string) int64 {
	lines := strings.Split(*data, "\n")
	values := []int8{}
	sum := int64(0)

	for _, line := range lines {
		size := len(line)
		var left *string
		var right *string

		for i := 0; i < size; i++ {
			if left != nil {
				break
			}

			if unicode.IsDigit(rune(line[i])) {
				leftStr := string(line[i])
				left = &leftStr
			}

			if i+3 < size {
				if line[i:i+3] == ONE {
					left = &DIGIT_ONE
					break
				}
				if line[i:i+3] == TWO {
					left = &DIGIT_TWO
					break
				}
				if line[i:i+3] == SIX {
					left = &DIGIT_SIX
					break
				}
			}

			if i+4 < size {
				if line[i:i+4] == FOUR {
					left = &DIGIT_FOUR
					break
				}
				if line[i:i+4] == FIVE {
					left = &DIGIT_FIVE
					break
				}
				if line[i:i+4] == NINE {
					left = &DIGIT_NINE
					break
				}
			}

			if i+5 < size {
				if line[i:i+5] == THREE {
					left = &DIGIT_THREE
					break
				}
				if line[i:i+5] == SEVEN {
					left = &DIGIT_SEVEN
					break
				}
				if line[i:i+5] == EIGHT {
					left = &DIGIT_EIGHT
					break
				}
			}
		}

		for i := len(line); i >= 0; i-- {
			if right != nil {
				break
			}

			if unicode.IsDigit(rune(line[i-1])) {
				rightStr := string(line[i-1])
				right = &rightStr
			}

			if i-3 >= 0 {
				if line[i-3:i] == ONE {
					right = &DIGIT_ONE
					break
				}
				if line[i-3:i] == TWO {
					right = &DIGIT_TWO
					break
				}
				if line[i-3:i] == SIX {
					right = &DIGIT_SIX
					break
				}
			}

			if i-4 >= 0 {
				if line[i-4:i] == FOUR {
					right = &DIGIT_FOUR
					break
				}
				if line[i-4:i] == FIVE {
					right = &DIGIT_FIVE
					break
				}
				if line[i-4:i] == NINE {
					right = &DIGIT_NINE
					break
				}
			}

			if i-5 >= 0 {
				if line[i-5:i] == THREE {
					right = &DIGIT_THREE
					break
				}
				if line[i-5:i] == SEVEN {
					right = &DIGIT_SEVEN
					break
				}
				if line[i-5:i] == EIGHT {
					right = &DIGIT_EIGHT
					break
				}
			}
		}

		if left == nil || right == nil {
			log.Fatal("Failed to find the value for 'left' or 'right'")
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
