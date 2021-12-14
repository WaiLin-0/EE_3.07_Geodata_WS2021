# Installation of GDAL and GEOPANDAS (PYPROJ) in a Clean Conda Environment

he attempt to install gdal by calling `conda install -c conda-forge gdal` in the base environment of conda leads often to conflicts and is refused. But if this installation works for you do not need to create another environment and coud stop reading.

Environments are very useful and highly recommended anyway to have full control of kernel and package versions. Some software development projects require the combination of packages with dedicated version numbers. A virtual environment provides a fully controlled and independent sandbox of installed components.

The following steps explain how to set up a new conda environment and to install software into it. It is demonstrated how **Jupyter-Lab** can be started in this environment. Environment setup as well as software installation can be performed with command line or with the Anaconda Navigator.

Please consult the very useful conda cheat sheet:<br>
https://kapeli.com/cheat_sheets/Conda.docset/Contents/Resources/Documents/index

Some more helpful information on environments in Jupyter:<br>
http://nero-docs.stanford.edu/jupyter-customEnv.html

## Create a New Conda Environment

On Windows: Open an Anaconda Powershell Prompt (Start -> Anaconda3 -> Anaconda Powershell Prompt). On other operating systems open a terminal. On the command line prompt you should see an indicator which Python environment is currently active, e.g. `(base) PS C:\Users\me`

The token `(base)` shows the active environment.

```bash
#  List all environments
conda info --envs

# show conda configuration
conda config --show

# Look at the order of the channels. Make sure that conda-forge comes first. Change channel priority from flexible to strict. 
conda config --prepend channels conda-forge
conda config --set channel_priority strict

# In case you want do DELETE an OLD environment
conda env remove --name geo

# CREATE NEW the new environment called geo with the python version of your choice 
conda create --name geo python=3.8 # for the specific version 3.8 or use python=3 for the latest version

# activate the new enviroment
conda activate geo # IMPORTANT!!!

# Install JupyterLab meta-package
conda install jupyterlab

# Install geopandas-metapackage (installation of pandas, numpy etc.)
conda install geopandas 

# numpy, pandas, gdal, etc. are installed in the scope of these meta-packages 
```

Start Jupyter-Lab from the command line in the active environment:
```
jupyter-lab
```

## Create a New Conda Environment, condensed

```
conda config --prepend channels conda-forge
conda config --set channel_priority strict
conda create --name geo python=3 jupyterlab geopandas
conda activate geo
jupyter-lab
```


## ISSUES: PROJ (GEOPANDAS, GDAL) ISSUE!!! (2021-10-25)

Installing `pyproj` with `conda` sometimes does not set the environment variable **`PROJ_LIB`** in the current conda environment. <br>
**Workaround 1: Set the environment variable explicitly in your Python code!**

```
import os
print(os.environ['PROJ_LIB'])
print(os.environ['GDAL_DATA'])

-> C:\OSGeo4W64\share\proj (wrong!)
-> C:\Users\me\Anaconda3\envs\geo\Library\share\gdal

# Set the env var
os.environ['PROJ_LIB'] = r'C:\Users\me\Anaconda3\envs\geo\Library\share\proj'
print(os.environ['PROJ_LIB'])
print(os.environ['GDAL_DATA'])

-> C:\Users\me\Anaconda3\envs\geo\Library\share\proj (correct!)
-> C:\Users\me\Anaconda3\envs\geo\Library\share\gdal

# Now geopandas (i.e. the projection module as part of it) should work:
import geopandas as gpd

```

**Workaround 2: Set the environment variable in your canda environment**

On Windows use the Anaconda power shell and activate the conda environment you want to work with:

```
# acitvate conda env
conda activate geo

# list operating system (Windows) environment variables 
Get-ChildItem -Path Env:\

-> PROJ_LIB                       C:\OSGeo4W64\share\proj (wrong!)

$env:PROJ_LIB="C:\Users\me\Anaconda3\envs\geo\Library\share\proj"

jupyter-lab
```





## Start Jupyter-Lab and Test the Installation ##

Open an Anaconda terminal, activate the new environment by calling `conda activate geo` on the command line and start Jupyter lab in the browser by calling `jupyter-lab` on the command line. This causes Jupyter-Lab to tun in the new environment where gdal is insatlled. In Jupyter Lab create a new notebook and check, whether you can execute the following command: <br>`from osgeo import osr, ogr, gdal`.
