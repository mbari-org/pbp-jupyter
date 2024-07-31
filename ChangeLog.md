2024-07

- gizo setup now with `/opt/pbp_workspace/` as host location for persistence.
- Updated dockerization to fix permission issues.
- Wrote and tested `HMB_generation_one_day.ipynb`,
  a simplified notebook for processing a single NRS11 day.
- New file structure (under `/opt/pbp_workspace/`) as discussed today (2024-07-30).
  With NRS11 as an example:

    ```
    NRS11/
        HMB_generation_one_day.ipynb
        metadata/
            json/
              2020/
                20200101.json
                ...
            calibration/
                NRS11_H5R6_sensitivity_hms5kHz.nc
            attribute/
                globalAttributes_NRS11.yaml
                variableAttributes_NRS11.yaml
        output/
        downloads/
    ```

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