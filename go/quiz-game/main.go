package main

import "fmt"

func main() {
	fmt.Println("Welcome to my quiz game!")

	var name string
	fmt.Print("Please type your name: ")
	fmt.Scan(&name)

	fmt.Printf("Hey there! %v let's play a game! \n", name)
}
