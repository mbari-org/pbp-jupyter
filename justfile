# List recipes
list:
    @just --list --unsorted

image := "mbari/pbp-jupyter:1.0.10"

# Create docker image
dockerize:
    docker build -t {{image}} .

# Run docker image (non-interactive)
run:
    docker run --rm -p 8888:8888 --name pbp-jupyter {{image}}

# Run docker image (interactive)
run-it:
    docker run -it --rm -p 8888:8888 --name pbp-jupyter {{image}}
