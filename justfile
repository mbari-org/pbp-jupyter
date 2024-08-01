set dotenv-load := true

# List recipes
list:
    @just --list --unsorted

# Prepare with given pbp package version and host workspace location
prepare version host_workspace:
  @echo "export PBP_VERSION={{version}}"                    >  .env
  @echo "export PBP_IMAGE=mbari/pbp-jupyter:{{version}}"   >>  .env
  @echo "export HOST_WORKSPACE={{host_workspace}}"         >>  .env
  @cat .env

# Create docker image
dockerize:
    #!/usr/bin/env bash
    set -eu
    cat .env
    cd root
    docker build \
          -f ../Dockerfile \
          -t $PBP_IMAGE \
          --build-arg PBP_VERSION=$PBP_VERSION \
          --build-arg USER_UID=$(id -u) \
          .

# Run image via compose
up *args="-d":
    docker compose up {{args}}

# Shutdown launched image via compose
down *args="":
    docker compose down {{args}}

# Tail pbp-jupyter container logs
logs tail="100":
    docker logs --tail={{tail}} -f pbp-jupyter

# Run docker image (non-interactive)
run:
    docker run --rm -p 8888:8888 --name pbp-jupyter $PBP_IMAGE

# Run docker image (interactive)
run-it:
    docker run -it --rm -p 8888:8888 --name pbp-jupyter $PBP_IMAGE

## Though the main purpose is running jupyter, one can also run the CLI programs directly:
## Again, note that volume mapping(s) would be needed to access local filesystem.

# Run pbp-json-gen
pbp-json-gen *args="":
    just _run-cli pbp-json-gen {{args}}

# Run pbp
pbp *args="":
    just _run-cli pbp {{args}}

# Run pbp-plot
pbp-plot *args="":
    just _run-cli pbp-plot {{args}}

_run-cli cli *args="":
    docker run -it --rm --name {{cli}} $PBP_IMAGE {{cli}} {{args}}
