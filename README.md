# pbp-jupyter

This repo is used to create the `mbari/pbp-jupyter` docker image,
which provides a JupyterLab environment with the `mbari-pbp` package already installed.

## Deployment

The steps are basically: preparation, dockerization, and use.

With a clone of this repo, you can proceed as follows:

- Decide on the version of the `mbari-pbp` package to be used.
- Decide on the host directory to be mapped to the `workspace/` directory
  in the JupyterLab environment.
- Decide on the authentication token (optional but recommended for persistent access).

We use the [`just`](https://just.systems) tool for convenience, but the steps can also be run
more manually with direct `docker` commands (see the `justfile` for the details).

- Prepare the environment:
  ```
  just prepare <pbp_version> <host_workspace> <token>
  ```
    For example:
    ```
    just prepare 1.2.4 /path/to/host/workspace my-secure-token
    ```

- Create the docker image:
  ```
  just dockerize
  ```
  The image will be tagged according to the given mbari-pbp version.

- Run the docker image:
  ```
  just up
  just logs
  ```
- Access the JupyterLab environment in your browser using the URL with your configured token:
  ```
  http://localhost:8888/?token=my-secure-token
  ```
- Enjoy!

## Authentication

The JupyterLab environment supports persistent token-based authentication configured
via the `JUPYTER_TOKEN` environment variable. This token will remain the same across
container restarts, avoiding the hassle of dealing with expired or regenerated tokens.

**Authentication Options:**

1. **Fixed Token** (Recommended for shared access in private networks):
   - Set `JUPYTER_TOKEN` to your desired token in `.env`
   - Share the URL `http://your-server:8888/?token=your-token` with users
   - Token persists across container restarts

2. **No Authentication** (Only for completely private/trusted networks):
   - Set `JUPYTER_TOKEN=""` in `.env` to disable authentication
   - Users access via `http://your-server:8888/` with no token required

## Development/testing

The `root/` directory here, to be captured in the image, only contains a `README.md` file
oriented to the user of the JupiterLab environment.
TODO maybe add some basic demo notebooks there?

`test_workspace/` is only for testing purposes.

As a quick local exercising of the deployment procedure above:
```
just prepare 1.2.4 $(pwd)/test_workspace test-token
just dockerize
just up
```
Open your browser at `http://localhost:8888/?token=test-token`,
do some inspections, tests, etc.,
and finally:
```
just down
```
to stop the container.
