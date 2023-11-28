package repository

type IPhotoRepo interface {
}

type PhotoRepo struct{}

func NewPhotoRepo() *UserRepo {
	return &UserRepo{}
}
