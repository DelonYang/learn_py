#docker

### build

格式：`docker build -t Name .`

|:-:|:-:|
|-f|指定`Dockerfile`|
|-t|编辑`tag`|

### run

格式: `docker run [OPTION] IMAGE [COMMAND]`
|:-:|:-:|
|-i|交互式界面，默认false|
|-t|伪终端|
|--name|别名，默认随机|
|--rm|容器退出后即删除|
|-d|后台运行|
|-p|端口映射,本地端口:容器端口|
|--init|-|
|--ip|设置ip|
|--mac-address|设置mac|