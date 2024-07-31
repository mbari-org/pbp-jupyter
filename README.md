# PBP for Jupyter Lab

mbari/pbp-jupyter docker image.

WIP

Being tested on `gizo`.

## Use

- The `workspace/` directory included in the Jupyter environment is mapped
  to the host's `/opt/pbp_workspace/` directory.

## Setup

On `gizo`: 
```
cd /PAM_Analysis/github/pbp-jupyter
```

Preparation depending on PBP package version:
```
just prepare <pbp package version>   #  e.g., 1.0.11
```
This puts some info in `.env` for the other commands to use.

Create the docker image (if not already done for the prepared version):
```
just dockerize
```

Run the docker image:
```
just up
just logs
```
Take note of the token included in the logs.

- Open http://gizo.shore.mbari.org:8888/tree in your browser
- enter the token
- Enjoy!
