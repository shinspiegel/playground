package services

type ITripService interface{}

type TripService struct{}

func NewTripService() *TripService {
	return &TripService{}
}
