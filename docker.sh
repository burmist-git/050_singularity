#!/bin/bash

function docker_build_sh {
    time docker build -f Dockerfile -t test $PWD
}

function docker_export_sh {
    docker run -it --name test test /bin/true
    sleep 1
    docker export test > test.tar
    du -hs test.tar
    ls test.tar
}

function singularity_sh {
    #singularity build test.sif test.tar
    singularity build test.sif docker-daemon://test:latest
    du -hs test.sif
    singularity run -B $PWD:/test test.sif ls /test
}

function singularity_centos_sh {
    docker pull centos:latest
    singularity build centos.sif docker-daemon://centos:latest
    singularity run centos.sif ls /
}

function clean_sh {
    rm -rf centos.sif test.sif  test.tar
    rm -rf *~
}
   
function printHelp {
    echo " --> ERROR in input arguments"
    echo " -h           : print help"
    echo " -b           : create docker image"
    echo " -e           : export docker image to .tar"
    echo " -c           : clean images"
    echo " -singularity : build singularity image from docker image"
    echo " -centos      : build singularity for centos"
    echo " --li         : list images"
    echo " --lc         : list containers"
}

if [ $# -eq 0 ]; then
    printHelp
else
    if [ "$1" = "-h" ]; then
	printHelp
    elif [ "$1" = "-b" ]; then
	docker_build_sh
    elif [ "$1" = "-e" ]; then
	time docker_export_sh
    elif [ "$1" = "-c" ]; then
	clean_sh
    elif [ "$1" = "-singularity" ]; then
	time singularity_sh
    elif [ "$1" = "-centos" ]; then
	time singularity_centos_sh
    elif [ "$1" = "--li" ]; then
	docker images
    elif [ "$1" = "--li" ]; then
	docker images
    elif [ "$1" = "--lc" ]; then
	echo " " 
	echo "active" 
	docker ps
	echo " " 
	echo "all"
	docker ps -a
    else	
        printHelp
    fi
fi
