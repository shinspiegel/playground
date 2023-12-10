package models

type PhotoModel struct {
	Id        int64      `json:"id"`
	Latitude  int64      `json:"latitude"`
	Longitude int64      `json:"longitude"`
	Timestamp int64      `json:"timestamp"`
	User      *UserModel `json:"user"`
	Trip      *TripModel `json:"trip"`
	TripId    int64
	UserId    int64
}
