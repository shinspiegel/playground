package main

import (
	"fmt"
	"time"
)

type Budget struct {
	CampaignId string
	Balance    float64 // usd
	Expires    time.Time
}

func (b Budget) TimeLeft() time.Duration {
	return b.Expires.Sub(time.Now().UTC())
}

func (b *Budget) IncrementBy(amount float64) {
	b.Balance += amount
}

func main() {
	b := Budget{"Kittens", 10.0, time.Now().Add(7 * 24 * time.Hour)}
	fmt.Println(b.TimeLeft())

	b.IncrementBy(100)
	fmt.Println(b)

}
