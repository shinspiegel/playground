package services

import (
	"math/rand"
	"strconv"
	"time"
)

type IRandomNumberService interface {
	generate(length int) string
}

type RandomNumberService struct{}

func NewRandomNumberService() *RandomNumberService {
	return &RandomNumberService{}
}

func (s *RandomNumberService) generate(length int) string {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))

	var result string
	for i := 0; i < length; i++ {
		number := r.Intn(10)
		result += strconv.Itoa(number)
	}

	return result
}
