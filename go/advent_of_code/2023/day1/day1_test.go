package day1_test

import (
	"advent-of-code-2023/day1"
	"advent-of-code-2023/reader"
	"testing"
)

func TestPartOne(t *testing.T) {
	sample := reader.GetFromFile(*reader.GetPwd() + "/sample.txt")

	res := day1.PartOne(sample)
	if res != 142 {
		t.Error("Not equal!")
	}
}
