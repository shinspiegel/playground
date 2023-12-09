package models

type TripModel struct {
	Id      int64  `json:"id"`
	User_id string `json:"userId"`
	Name    string `json:"name"`
}
