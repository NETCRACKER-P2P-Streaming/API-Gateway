package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"io/ioutil"

	"github.com/devopsfaith/krakend-ce"
	cmd "github.com/devopsfaith/krakend-cobra"
	flexibleconfig "github.com/devopsfaith/krakend-flexibleconfig"
	viper "github.com/devopsfaith/krakend-viper"
	"github.com/devopsfaith/krakend/config"
	"github.com/gin-gonic/gin"
)

const (
	fcPartials  = "FC_PARTIALS"
	fcTemplates = "FC_TEMPLATES"
	fcSettings  = "FC_SETTINGS"
	fcPath      = "FC_OUT"
	fcEnable    = "FC_ENABLE"
	adapter     = "AmazonCognitoAdapter"
	registry    = "StreamRegistry"
)

func main() {
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	go func() {
		select {
		case sig := <-sigs:
			log.Println("Signal intercepted:", sig)
			cancel()
		case <-ctx.Done():
		}
	}()

	data, errRead := ioutil.ReadFile("krakend.json")

	if errRead != nil {
		fmt.Println(errRead);
	}

	if os.Getenv(adapter) == "" {
		os.Setenv(adapter, "\"localhost:9090\"")
	}

	if os.Getenv(registry) == "" {
		os.Setenv(registry, "\"localhost:8080\"")
	}

	krakendStr := string(data)
	krakendEnvStr := os.ExpandEnv(krakendStr)

	errWrite := ioutil.WriteFile("krakendEnv.json", []byte(krakendEnvStr), 0777)

	if errWrite != nil {
		fmt.Println(errRead);
	}

	krakend.RegisterEncoders()

	var cfg config.Parser
	cfg = viper.New()
	if os.Getenv(fcEnable) != "" {
		cfg = flexibleconfig.NewTemplateParser(flexibleconfig.Config{
			Parser:    cfg,
			Partials:  os.Getenv(fcPartials),
			Settings:  os.Getenv(fcSettings),
			Path:      os.Getenv(fcPath),
			Templates: os.Getenv(fcTemplates),
		})
	}

	eb := krakend.ExecutorBuilder{
		Middlewares: []gin.HandlerFunc{func(c *gin.Context) {
			fmt.Println("dummy mw executed for req", c.Request.URL.String())
			c.Next()
		}},
	}

	cmd.Execute(cfg, eb.NewCmdExecutor(ctx))
}
