package main

import "fmt"

func main() {
	n := 5005
	s := fmt.Sprintf("%d", n)

	if s[0] == s[3] {
		fmt.Println("Equal")
	}
}
