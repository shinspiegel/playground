package day1_test

import (
	"advent-of-code-2023/day1"
	"advent-of-code-2023/reader"
	"testing"
)

func TestPartOne(t *testing.T) {
	sample := reader.GetFromFile("sample_part_one")

	res := day1.PartOne(sample)
	if res != 142 {
		t.Errorf("Failed! [%v]", res)
	}
}

func TestPartTwo(t *testing.T) {
	sample := reader.GetFromFile("sample_part_two")

	res := day1.PartTwo(sample)
	if res != 281 {
		t.Errorf("Failed! [%v]", res)
	}
}
