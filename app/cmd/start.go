package cmd

import (
	"fmt"
	"strings"

	"github.com/spf13/cobra"
)

func (c *command) initStartCmd() error {
	cmd := &cobra.Command{
		Use:   "start",
		Short: "start a demo service",
		Long:  "start a demo service",
		RunE: func(cmd *cobra.Command, args []string) error {
			if len(args) > 0 {
				return cmd.Help()
			}
			v := strings.ToLower(c.config.GetString(optionNameVerbosity))
			logger, err := c.NewLogger(v)
			if err != nil {
				return fmt.Errorf("new logger: %v", err)
			}

			logger.Info("init")

			return nil
		},
		PreRunE: func(cmd *cobra.Command, args []string) error {
			return c.config.BindPFlags(cmd.Flags())
		},
	}
	c.setAllFlags(cmd)
	c.root.AddCommand(cmd)
	return nil
}
