package main

import (
	"advent-of-code-2023/day1"
	"advent-of-code-2023/day2"
	"advent-of-code-2023/day3"
	"advent-of-code-2023/reader"
	"fmt"
)

func main() {
	d1p1 := day1.PartOne(reader.GetDay1())
	fmt.Printf("Day 1, Part 1::[%v]\n", d1p1)
	d1p2 := day1.PartTwo(reader.GetDay1())
	fmt.Printf("Day 1, Part 2::[%v]\n", d1p2)

	d2p1 := day2.PartOne(reader.GetDay2(), &day2.Cube{Red: 12, Green: 13, Blue: 14})
	fmt.Printf("Day 2, Part 1::[%v]\n", d2p1)
	d2p2 := day2.PartTwo(reader.GetDay2())
	fmt.Printf("Day 2, Part 2::[%v]\n", d2p2)

	d3p1 := day3.PartOne(reader.GetDay2())
	fmt.Printf("Day 3, Part 1::[%v]\n", d3p1)
	d3p2 := day3.PartTwo(reader.GetDay2())
	fmt.Printf("Day 3, Part 2::[%v]\n", d3p2)
}
