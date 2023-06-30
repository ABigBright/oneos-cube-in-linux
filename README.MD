# Docker container for oneos building

This is a Docker container for oneos-cube building in linux. It was created to support the oneos Open Source Project.  

## Generating a Docker image

1. Get the project  
```
$ git clone "this repo"
```
> "this repo" substitude this repo url

2. Go into root of oneos-cube-in-linux  
```
$ cd oneos-cube-in-linux
```
3. Generating a Docker image  
```
$ docker build -t oneos-cube-in-linux:v1.0 .
```

## How to use

The container default working directory is `/home/oneos`, it is also a mountpoint that can be used to mount your current working directory into the container, like: 
```
 docker run -it --rm \
            -e USER_ID=`id -u` \
            --mount type=bind,source="$PWD",target="/home/oneos" \
            oneos-cube-in-linux
```
