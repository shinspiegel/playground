package day3_test

import (
	"advent-of-code-2023/day3"
	"advent-of-code-2023/reader"
	"testing"
)

func TestPartOne(t *testing.T) {
	sample := reader.GetFromFile("sample")

	res := day3.PartOne(sample)
	if res != 4363 {
		t.Errorf("Failed! [%v]", res)
	}
}

func TestPartTwo(t *testing.T) {
	// sample := reader.GetFromFile("sample")
	res := 0
	if res != 9999 {
		t.Errorf("Failed! [%v]", res)
	}
}
