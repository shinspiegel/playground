package main

import (
	"fmt"
	"time"
)

func main() {
	b1 := Budget{"Kittens", 22.3, time.Now().Add(7 * 24 * time.Hour)}
	fmt.Println(b1)
	fmt.Printf("%#v\n", b1)
	fmt.Println(b1.Expires)

	b2 := Budget{CampaignId: "Something"}
	fmt.Println(b2)
}

type Budget struct {
	CampaignId string
	Balance    float64 // usd
	Expires    time.Time
}
