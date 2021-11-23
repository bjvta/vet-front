# vet-api

## Requirements

- [Docker v19+](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [docker-compose v1.23+](https://docs.docker.com/compose/install/)
- [docker-compose via pip](https://pypi.org/project/docker-compose/)
- make

## Set up development environment

if you want to describe the images docker of gitlab

    shell
        docker login
        docker pull bjason01/vet-front:latest
        docker pull bjason01/vet-front:develop

### We run the development environment
In the root directory of the project.
Create a .env file, there you can custom environment variables if you need it.

     shell
        touch .env
        chmod 600 .env

Type in the bash

        make frontend

Inside the container 
        
        yarn install

Now we can run the project, inside the container please

        make runserver


Then you can go to http://0.0.0.0:3000