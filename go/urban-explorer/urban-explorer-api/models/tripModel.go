package models

type TripModel struct {
	Id      int64         `json:"id"`
	User_id int64         `json:"userId"`
	Name    string        `json:"name"`
	Photos  *[]PhotoModel `json:"photos,omitempty"`
}
