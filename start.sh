запуск на windows
open cmd and set env vars
set FC_OUT=PATH\API-Gateway\go\bin
set FC_TEMPLATES=PATH\API-Gateway\go\bin\config\templates
set FC_SETTINGS=PATH\API-Gateway\go\bin\config\settings
set FC_PARTIALS=PATH\API-Gateway\go\bin\config\partials
go build
API-Gateway run -c krakend.json(API-Gateway имя exe)

но если при запуске из под windows будет ошибка об sys log from module config, то просто закомментировать подчеркиваемые строки в зависимости модуля config
(под линукс и с использованием докер образа такой проблемы не будет)

запуск с докером:
docker build .
docker run -p 7070:7070 id container