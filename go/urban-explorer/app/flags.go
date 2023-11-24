package app

import "flag"

type Flags struct {
	EnvFile string
	IsTest  bool
}

func NewFlags() *Flags {
	f := Flags{
		EnvFile: *flag.String("env", "", "Path to the .env file"),
		IsTest:  *flag.Bool("test", false, "Test Environment"),
	}

	flag.Parse()

	return &f
}
