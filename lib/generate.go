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

	err := os.MkdirAll(filepath.Join(".", "build", "pkg", "cmd"), os.ModePerm)
	if err != nil {
		return err
	}

	//err = os.MkdirAll(filepath.Join(".", ))

	err = generate.WriteFile(box, "cli", "build/pkg/main", spec1)
	if err != nil {
		return err
	}
	err = generate.WriteFile(box, "cli_cmd", "build/pkg/cmd", spec1)
	if err != nil {
		return err
	}
	return nil
}
