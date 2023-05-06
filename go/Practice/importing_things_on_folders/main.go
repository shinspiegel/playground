package main

import (
	"fmt"
	first "shin/inner_folder"
	second "shin/other_folder"
)

func main() {
	fmt.Println("Printed")
	a := first.GetTwo()
	b := second.GetThree()
	c := second.GetTwo()
	fmt.Println(a + b + c)
}
