package lib

import (
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



	err := os.MkdirAll(filepath.Join(".", "build", programName, "cmd"), os.ModePerm)
	if err != nil {
		return err
	}

	err = generate.WriteFile(box, "main", filepath.Join("build", programName), spec1)
	if err != nil {
		return err
	}
	err = generate.WriteFile(box, "cli_cmd", filepath.Join("build", programName, "cmd"), spec1)
	if err != nil {
		return err
	}
	return nil
}
