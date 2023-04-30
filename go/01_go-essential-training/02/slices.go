package main

import "fmt"

func main() {
	loon := []string{"bugs", "thing", "other"}

	fmt.Println(len(loon)) // 3

	for i, name := range loon {
		fmt.Printf("%s at %d \n", name, i)
	}

	for _, name := range loon {
		fmt.Printf("%s,", name)
	}
	fmt.Println("")

}
