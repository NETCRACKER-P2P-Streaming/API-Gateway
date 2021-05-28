#!/bin/bash

# Для windows возможны ошибки связанные c syslog
# Достаточно закомитеть/удалить связанный с этим блок кода из указанного места
# (даб, прям из зависимости)


if [[ $# -ge 3 ]]; then
    echo -n "[ERROR] A lof of arguments"
else

mode=docker
if [[ $# -ne 0 ]]
    then
        mode=$1
fi

success=1
case $mode in
    docker)
        docker-compose -f docker-compose.yml up
        ;;
    local)
        cd go/bin/
        if [[ $# -eq 2 ]]; then    
            if [[ "$2" == "--build" ]]
            then
                # Возможно требование загрузки дополнительных зависимостей через `go get`
                go mod tidy 
                go build main.go
            else
                echo -n "[ERROR] Uknown option"
                success=0
            fi
        fi
        export FC_ENABLE=1
        export FC_SETTINGS=./config/settings
        export FC_PARTIALS=./config/partials
        export FC_OUT=./compiled-krakend.json
        export FC_TEMPLATES=./config/templates
        export AmazonCognitoAdapter=\"localhost:9090\"
        export StreamRegistry=\"localhost:8080\"
        ./main.exe run -c krakendEnv.json
        ;;
    *)
        echo -n "[ERROR] Unknown mode"
        success=0
        ;;
esac

fi

if [[ $success -eq 0 ]]; then
echo -n "Usages:"
echo -n "       start.sh [mode] [arguments]"
echo -n "The modes are:"
echo -n "       docker      starts docker compose (default)"
echo -n "       local       starts local main.exe file"
echo -n "The arguments are:"
echo -n "       --build     builds main.exe file (only available in 'local' mode)"
fi
