set dotenv-load := true

# List recipes
list:
    @just --list --unsorted

pbp_version := "1.0.11"
image := "mbari/pbp-jupyter:" + pbp_version

## NOTE: NO volume mapping(s) below for simplicity.

# Create docker image
dockerize:
    docker build -t {{image}} --build-arg PBP_VERSION={{pbp_version}} .

# Run docker image (non-interactive)
run:
    docker run --rm -p 8888:8888 --name pbp-jupyter {{image}}

# Run docker image (interactive)
run-it:
    docker run -it --rm -p 8888:8888 --name pbp-jupyter {{image}}

## Though the main purpose is running jupyter, one can also run the CLI programs directly:
## Again, note that volume mapping(s) would be needed to access local filesystem.

# Run pbp-json-gen
pbp-json-gen *args="":
    docker run -it --rm --name pbp {{image}} pbp-json-gen {{args}}

# Run pbp
pbp *args="":
    docker run -it --rm --name pbp {{image}} pbp {{args}}

# Run pbp-plot
pbp-plot *args="":
    docker run -it --rm --name pbp {{image}} pbp-plot {{args}}
