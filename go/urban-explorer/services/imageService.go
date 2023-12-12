package services

import (
	"bytes"
	"image"
	"image/jpeg"
	"math"
	"mime/multipart"

	"github.com/nfnt/resize"
)

type IImageService interface {
	ResizeForDB(image *multipart.FileHeader, opt *ResizeOptions) (*[]byte, error)
}

type ImageService struct{}

func NewImageService() *ImageService {
	return &ImageService{}
}

type ResizeOptions struct {
	Height  uint
	Width   uint
	Quality int
}

func (s *ImageService) ResizeForDB(img *multipart.FileHeader, opt *ResizeOptions) (*[]byte, error) {
	if opt == nil {
		opt = &ResizeOptions{
			Height:  300,
			Width:   300,
			Quality: 100,
		}
	}

	file, err := img.Open()
	if err != nil {
		return nil, err
	}
	defer file.Close()

	decoded, err := jpeg.Decode(file)
	if err != nil {
		return nil, err
	}

	bounds := decoded.Bounds()
	minDim := math.Min(float64(bounds.Dx()), float64(bounds.Dy()))
	startX := (bounds.Dx() - int(minDim)) / 2
	startY := (bounds.Dy() - int(minDim)) / 2
	squareImg := decoded.(interface {
		SubImage(r image.Rectangle) image.Image
	}).SubImage(image.Rect(startX, startY, startX+int(minDim), startY+int(minDim)))

	resizedImg := resize.Resize(opt.Width, opt.Height, squareImg, resize.Lanczos3)

	resizeBuf := new(bytes.Buffer)
	err = jpeg.Encode(resizeBuf, resizedImg, &jpeg.Options{Quality: opt.Quality})

	if err != nil {
		return nil, err
	}

	bytes := resizeBuf.Bytes()

	return &bytes, nil
}
