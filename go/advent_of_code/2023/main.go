package main

import (
	"advent-of-code-2023/day2"
	"advent-of-code-2023/reader"
	"fmt"
)

func main() {
	res := day2.PartOne(reader.GetDay2(), &day2.Cube{Red: 12, Green: 13, Blue: 14})
	fmt.Println(res)
}
