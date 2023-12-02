package day2_test

import (
	"advent-of-code-2023/day2"
	"advent-of-code-2023/reader"
	"testing"
)

func TestPartOne(t *testing.T) {
	sample := reader.GetFromFile("sample")

	cube := &day2.Cube{
		Red:   12,
		Green: 13,
		Blue:  14,
	}
	res := day2.PartOne(sample, cube)
	if res != 8 {
		t.Errorf("Failed! [%v]", res)
	}
}

func TestPartTwo(t *testing.T) {
	sample := reader.GetFromFile("sample")
	res := day2.PartTwo(sample)
	if res != 2286 {
		t.Errorf("Failed! [%v]", res)
	}
}
