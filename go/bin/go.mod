module API-Gateway

go 1.16

require (
	github.com/devopsfaith/krakend v1.3.0
	github.com/devopsfaith/krakend-ce v1.3.0
	github.com/devopsfaith/krakend-cobra v0.0.0-20200317174411-3518505e8cd2
	github.com/devopsfaith/krakend-flexibleconfig v0.0.0-20210222183249-754d3c696149
	github.com/devopsfaith/krakend-viper v0.0.0-20210413161812-18960352c610
	github.com/dlclark/regexp2 v1.4.0 // indirect
	github.com/gin-gonic/gin v1.7.1
	github.com/klauspost/compress v1.11.8 // indirect
	golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83 // indirect
	golang.org/x/net v0.0.0-20210226101413-39120d07d75e // indirect
	golang.org/x/sys v0.0.0-20210225134936-a50acf3fe073 // indirect
	golang.org/x/text v0.3.5 // indirect
)

replace github.com/devopsfaith/krakend v1.3.0 => github.com/kristosiisusov/krakend v1.3.2
