Example tar without compressing and avoid (absolute) long path:
The simplest solution is to "cd" in to source_path (parent directory of source_dir) and run the "tar target_path/file.tar.gz source_dir" in your script. This will remove absolute path prefix in your generated tar.gz file's directory structure.

edwin@tcn958:/scratch-shared/edwin/05min_runs_may_2016$ ls
...
pcrglobwb_modflow_from_1901_6LCs_adjusted_ksat                              pcrglobwb_modflow_from_1901_6LCs_original_parameter_set
...
edwin@tcn958:/scratch-shared/edwin/05min_runs_may_2016$ 
edwin@tcn958:/scratch-shared/edwin/05min_runs_may_2016$ tar -cvf /projects/0/wtrcycle/users/edwin/05min_runs_may_2016/pcrglobwb_modflow_from_1901_6LCs_adjusted_ksat.tar pcrglobwb_modflow_from_1901_6LCs_adjusted_ksat
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

