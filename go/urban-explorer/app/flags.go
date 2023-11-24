package app

import "flag"

type Flags struct {
	EnvFile string
	IsTest  bool
}

func NewFlags() *Flags {
	envFile := flag.String("env", "", "Path to the .env file")
	isTest := flag.Bool("test", false, "Test Environment")

	flag.Parse()

	return &Flags{
		EnvFile: *envFile,
		IsTest:  *isTest,
	}
}
