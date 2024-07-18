# List recipes
list:
    @just --list --unsorted

image := "mbari/pbp-jupyter:1.0.8"

# Create docker image
dockerize:
    docker build -t {{image}} .

# Run docker image
run:
    docker run -it --rm -p 8888:8888 {{image}}
