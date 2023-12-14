package models

type PhotoModel struct {
	Id        int64      `json:"id"`
	Latitude  float64    `json:"latitude"`
	Longitude float64    `json:"longitude"`
	Timestamp int64      `json:"timestamp"`
	User      *UserModel `json:"user,omitempty"`
	Trip      *TripModel `json:"trip,omitempty"`
	TripId    int64      `json:"-"`
	UserId    int64      `json:"-"`
	JpegBytes []byte     `json:"-"`
}
