package main

import "fmt"

func main() {
	worker()
}

func worker() {
	r1, err := acquire("A")
	if err != nil {
		fmt.Println("ERROR:", err)
	}
	defer release(r1)

	r2, err := acquire("B")
	if err != nil {
		fmt.Println("ERROR:", err)
	}
	defer release(r2)

	fmt.Println("Worker")
}

func acquire(name string) (string, error) {
	return name, nil
}

func release(name string) {
	fmt.Println("Cleaning", name)
}
