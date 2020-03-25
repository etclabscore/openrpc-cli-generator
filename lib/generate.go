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


	targetPath := filepath.Join(".", "build", "target")
	targetPath =  filepath.Join(targetPath, "go") // TODO

	err := os.MkdirAll(filepath.Join(".", targetPath, programName, "cmd"), os.ModePerm)
	if err != nil {
		return err
	}

	if err = generate.WriteFile(box, "server", filepath.Join(targetPath, programName, "cmd"), spec1); err != nil {
		return err
	}

	if err = generate.WriteFile(box, "types", filepath.Join(targetPath, programName, "cmd"), spec1); err != nil {
		return err
	}

	err = generate.WriteFile(box, "main", filepath.Join(targetPath, programName), spec1)
	if err != nil {
		return err
	}
	err = generate.WriteFile(box, "cli_cmd", filepath.Join(targetPath, programName, "cmd"), spec1)
	if err != nil {
		return err
	}

	// HACK,FIXME.
	bs, err := ioutil.ReadFile(filepath.Join(targetPath, programName, "main.go"))
	if err != nil {
		return err
	}
	bs = bytes.Replace(bs, []byte("package "+programName), []byte("package main"), 1)
	err = ioutil.WriteFile(filepath.Join(targetPath, programName, "main.go"), bs, os.ModePerm)
	if err != nil {
		return err
	}
	//err = ioutil.WriteFile(filepath.Join(".", targetPath, programName, "go.mod"), nil, os.ModePerm)
	//if err != nil {
	//	return err
	//}
	return nil
}
