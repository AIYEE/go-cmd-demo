package cmd

import (
	"demo"

	"github.com/spf13/cobra"
)

func (c *command) initVersionCmd() {
	v := &cobra.Command{
		Use:   "version",
		Short: "Print version number",
		Run: func(cmd *cobra.Command, args []string) {
			cmd.Println(demo.Version)
		},
	}
	v.SetOut(c.root.OutOrStdout())
	c.root.AddCommand(v)
}
