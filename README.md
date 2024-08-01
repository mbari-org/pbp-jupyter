# pbp-jupyter

This repo is used to create the `mbari/pbp-jupyter` docker image,
which provides a Jupyter environment with the `mbari-pbp` package already installed.

## Deployment

The steps are basically: preparation, dockerization, and use.

With a clone of this repo, you can proceed as follows:

- Decide on the version of the `mbari-pbp` package to be used.
- Decide on the host directory to be mapped to the `workspace/` directory in the Jupyter environment.

We use the [`just`](https://just.systems) tool for convenience, but the steps can also be run
more manually with direct `docker` commands (see the `justfile` for the details).

- Prepare the environment:
  ```
  just prepare <pbp_version> <host_workspace>
  ```
    For example:
    ```
    just prepare 1.0.11 /path/to/host/workspace
    ```
  
- Create the docker image:
  ```
  just dockerize
  ```
  The image will be tagged according to the given mbari-pbp version,
  for example, `mbari/pbp-jupyter:1.0.11`.

- Run the docker image:
  ```
  just up
  just logs
  ```
- From the log output, open the indicated URL in your browser.
- Enjoy!

## Development/testing

The `root/` directory here, to be captured in the image, only contains a `README.md` file
oriented to the user of the Jupiter environment.
TODO maybe add some basic demo notebooks there?

`test_workspace/` is only for testing purposes.

As a quick local exercising of the deployment procedure above: 
```
just prepare 1.0.11 $(pwd)/test_workspace
just dockerize
just up
just logs
```
Open the indicated URL in the browser, do some inspections, tests, etc.,
and finally:
```
just down
```
to stop the container.
