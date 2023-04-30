package main

import "fmt"

func main() {
	book := "The color of magic"

	fmt.Println(book)
	fmt.Println(len(book))

	fmt.Printf("book[0] = %v (type %T)", book[0], book[0])
	fmt.Println("")

	fmt.Println(book[0:3])
	fmt.Println(book[0:3] + "A")

	poem := `
		Something
		Another line
		And Another
		...`

	fmt.Println(poem)
}
