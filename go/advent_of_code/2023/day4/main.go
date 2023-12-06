package day4

import (
	"log"
	"slices"
	"strconv"
	"strings"
)

type Card struct {
	CardId     string
	Winners    []int64
	Choices    []int64
	Value      int64
	NextAffect int64
	Copies     int64
}

func (c *Card) SumPoints() int64 {
	for _, num := range c.Winners {
		if slices.Contains(c.Choices, num) {
			if c.Value <= 0 {
				c.Value = 1
			} else {
				c.Value *= 2
			}

			c.NextAffect += 1

		}
	}

	c.Copies = 1

	return c.Value
}

func processAllCards(data string) []Card {
	cards := []Card{}
	data = strings.ReplaceAll(data, "  ", " ")
	lines := strings.Split(data, "\n")
	for _, line := range lines {
		card := Card{}

		parts := strings.Split(line, ": ")
		numbersString := strings.Split(parts[1], " | ")
		winnerNumbers := strings.Split(numbersString[0], " ")
		choiceNumbers := strings.Split(numbersString[1], " ")

		card.CardId = parts[0]

		for _, winNum := range winnerNumbers {
			num, err := strconv.ParseInt(winNum, 10, 64)
			if err != nil {
				log.Fatal(err)
			}

			card.Winners = append(card.Winners, num)
		}

		for _, choiceNum := range choiceNumbers {
			num, err := strconv.ParseInt(choiceNum, 10, 64)
			if err != nil {
				log.Fatal(err)
			}

			card.Choices = append(card.Choices, num)
		}

		card.SumPoints()
		cards = append(cards, card)
	}

	return cards
}

func PartOne(data string) int64 {
	sum := int64(0)
	cards := processAllCards(data)

	for _, card := range cards {
		sum += card.Value
	}

	return sum
}

func PartTwo(data string) int64 {
	sum := int64(0)
	cards := processAllCards(data)

	for index, card := range cards {
		if card.Copies > 1 {
			for j := 0; j < int(card.Copies-1); j++ {
				for i := 0; i < int(card.NextAffect); i++ {
					cards[index+i+1].Copies += 1
				}
			}
		}

		for i := 0; i < int(card.NextAffect); i++ {
			cards[index+i+1].Copies += 1
		}
	}

	for _, card := range cards {
		sum += card.Copies
	}

	return sum
}
