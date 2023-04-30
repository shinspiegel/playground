package main

import "fmt"

func main() {
	fmt.Println(add(1, 3))
	fmt.Println(div_mod(5, 2))
}

func add(a int, b int) int {
	return a + b
}

func div_mod(a int, b int) (int, int) {
	return a / b, a % b
}
