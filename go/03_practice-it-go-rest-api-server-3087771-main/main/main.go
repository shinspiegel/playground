package main

import (
	"fmt"
	"log"
	"net/http"
)

func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello World")

}

func main() {
	http.HandleFunc("/", helloWorld)
	fmt.Println("Starting the server")
	log.Fatal(http.ListenAndServe(":4040", nil))
}
