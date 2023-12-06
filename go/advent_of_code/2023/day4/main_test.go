package day4_test

import (
	"advent-of-code-2023/day4"
	"advent-of-code-2023/reader"
	"testing"
)

func TestPartOne(t *testing.T) {
	sample := reader.GetFromFile("sample")

	res := day4.PartOne(*sample)
	if res != 13 {
		t.Errorf("Failed! [%v]", res)
	}
}

func TestPartTwo(t *testing.T) {
	sample := reader.GetFromFile("sample")
	res := day4.PartTwo(*sample)
	if res != 30 {
		t.Errorf("Failed! [%v]", res)
	}
}
