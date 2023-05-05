package main

import "fmt"

func main() {
	stocks := map[string]float64{
		"AMZN": 2034.0123,
		"GOOG": 12385.293,
		"MSFT": 1239.2349,
	}

	fmt.Println(len(stocks))
	fmt.Println("-----")
	fmt.Println(stocks["AMZN"])
	fmt.Println(stocks["AAAA"])

	fmt.Println("-----")
	v, ok := stocks["AAAA"]
	if !ok {
		fmt.Println("Failed")
	} else {
		fmt.Println(v)
	}

	fmt.Println("-----")
	v1, ok1 := stocks["GOOG"]
	if !ok1 {
		fmt.Println("Failed")
	} else {
		fmt.Println(v1)
	}

	stocks["TSLA"] = 5443.123
	fmt.Println(stocks)

	delete(stocks, "AMZN")
	fmt.Println(stocks)

	for key, value := range stocks {
		fmt.Printf("%s -> %.2f \n", key, value)
	}
}
