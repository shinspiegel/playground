package main

import (
	"fmt"
	"math"
)

func main() {
	_, err := sqrt(-2.0)

	if err != nil {
		fmt.Printf("Error: %s\n", err)
	}

}

func sqrt(n float64) (float64, error) {
	if n < 0 {
		return 0, fmt.Errorf("Needs to be positive")
	}

	return math.Sqrt(n), nil
}
