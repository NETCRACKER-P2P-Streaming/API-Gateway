cd go/bin
set FC_ENABLE=1
set FC_SETTINGS=.\config\settings
set FC_PARTIALS=.\config\partials
set FC_OUT=.\compiled-krakend.json
set FC_TEMPLATES=.\config\templates
set AmazonCognitoAdapter="localhost:9090"
set StreamRegistry="localhost:8080"
call main run -c krakendEnv.json
