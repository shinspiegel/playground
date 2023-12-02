package reader_test

import (
	"advent-of-code-2023/reader"
	"fmt"
	"testing"
)

func TestReader(t *testing.T) {
	bytes := reader.GetFromFile("file")
	fmt.Print(bytes)
}
