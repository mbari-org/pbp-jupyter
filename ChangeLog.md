2024-07

- preliminary setup with `~carueda/pbp_workspace/` on gizo as host location for persistence.
  (IS ticket entered to create a more standard location for this purpose.)
  This corresponds to the `/workspace/` directory in the Jupyter environment.
  NOTE: some notebooks here now moved from this repo to that workspace.

- use h5netcdf engine for saving the output.
  Seems like netcdf4 was causing issues.
- added notebook for NRS11 exercise
    - including input files to have a self-contained example (as in original pbp repo)
    - Note: adjusting notebook initially put together in Colab.
    - TODO include JSON generation

- initial version