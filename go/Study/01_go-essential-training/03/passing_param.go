package main

import "fmt"

func main() {
	values := []int{1, 2, 3, 4}

	doubleAt(values, 2) //Passing the reference
	fmt.Println(values)

	val := 10
	doubleVal(val) // Passing the copy value, slice/map is reference
	fmt.Println(val)

	doubleByRef(&val)
	fmt.Println(val)
}

func doubleVal(val int) {
	val *= 2
}

func doubleAt(values []int, i int) {
	values[i] *= 2
}

func doubleByRef(n *int) {
	*n *= 2
}
