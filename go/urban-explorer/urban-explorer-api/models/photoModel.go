package models

type PhotoModel struct {
	Id        int64      `json:"id"`
	Latitude  float64    `json:"latitude"`
	Longitude float64    `json:"longitude"`
	Timestamp int64      `json:"timestamp"`
	User      *UserModel `json:"user"`
	Trip      *TripModel `json:"trip"`
	TripId    int64
	UserId    int64
	JpegBytes []byte
}
