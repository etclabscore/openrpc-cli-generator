package lib

import (
	"bytes"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/gobuffalo/packr/v2"
	"github.com/gregdhill/go-openrpc/generate"
	"github.com/gregdhill/go-openrpc/parse"
	"github.com/gregdhill/go-openrpc/types"
)

func GenerateCLI(spec1 *types.OpenRPCSpec1, programName string) error {
	parse.GetTypes(spec1, spec1.Objects)

	log.Println("OK: Have types.")
	box := packr.New("template", "./templates")

	generate.ProgramName = programName



	err := os.MkdirAll(filepath.Join(".", "build", "go", programName, "cmd"), os.ModePerm)
	if err != nil {
		return err
	}

	if err = generate.WriteFile(box, "server", filepath.Join("build", "go", programName, "cmd"), spec1); err != nil {
		return err
	}

	if err = generate.WriteFile(box, "types", filepath.Join("build", "go", programName, "cmd"), spec1); err != nil {
		return err
	}

	err = generate.WriteFile(box, "main", filepath.Join("build", "go", programName), spec1)
	if err != nil {
		return err
	}
	err = generate.WriteFile(box, "cli_cmd", filepath.Join("build", "go", programName, "cmd"), spec1)
	if err != nil {
		return err
	}

	// HACK,FIXME.
	bs, err := ioutil.ReadFile(filepath.Join("build", "go", programName, "main.go"))
	if err != nil {
		return err
	}
	bs = bytes.Replace(bs, []byte("package "+programName), []byte("package main"), 1)
	err = ioutil.WriteFile(filepath.Join("build", "go", programName, "main.go"), bs, os.ModePerm)
	if err != nil {
		return err
	}
	//err = ioutil.WriteFile(filepath.Join(".", "build", "go", programName, "go.mod"), nil, os.ModePerm)
	//if err != nil {
	//	return err
	//}
	return nil
}
