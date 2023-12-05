package day3

import (
	"log"
	"strconv"
	"strings"
	"unicode"
)

type Part struct {
	digits string
	isPart bool
}

func createGrid(data *string) [][]rune {
	grid := [][]rune{}
	for _, row := range strings.Split(*data, "\n") {
		cells := []rune{}

		for _, cell := range row {
			cells = append(cells, cell)
		}

		grid = append(grid, cells)
	}
	return grid
}

func haveSymbolNear(grid [][]rune, x int, y int) bool {
	maxX := len(grid) - 1
	maxY := len(grid[0]) - 1

	pos := []rune{
		'.', // 0: Top
		'.', // 1: Bottom
		'.', // 2: Left
		'.', // 3: Right
		'.', // 4: TopLeft
		'.', // 5: TopRight
		'.', // 6: BottomLeft
		'.', // 7: BottomRight
	}

	if x > 0 {
		pos[0] = grid[x-1][y]
	}
	if x < maxX {
		pos[1] = grid[x+1][y]
	}
	if y > 0 {
		pos[2] = grid[x][y-1]
	}
	if y < maxY {
		pos[3] = grid[x][y+1]
	}
	if x > 0 && y > 0 {
		pos[4] = grid[x-1][y-1]
	}
	if x > 0 && y < maxY {
		pos[5] = grid[x-1][y+1]
	}
	if x < maxX && y > 0 {
		pos[6] = grid[x+1][y-1]
	}
	if x < maxX && y < maxY {
		pos[7] = grid[x+1][y+1]
	}

	for _, p := range pos {
		if !unicode.IsDigit(p) && p != '.' {
			return true
		}
	}

	return false
}

func PartOne(data *string) int64 {
	sum := int64(0)
	grid := createGrid(data)
	parts := []Part{}
	part := Part{}

	for xIndex, row := range grid {
		for yIndex, cell := range row {
			if unicode.IsDigit(cell) {
				part.digits += string(cell)

				if !part.isPart {
					part.isPart = haveSymbolNear(grid, xIndex, yIndex)
				}
			} else {
				if part.isPart {
					parts = append(parts, part)
				}

				part = Part{}
			}
		}
	}

	for _, p := range parts {
		val, err := strconv.ParseInt(p.digits, 10, 64)
		if err != nil {
			log.Fatal(err)
		}
		sum += val
	}

	return sum
}

func PartTwo(data *string) int64 {
	return int64(0)
}
