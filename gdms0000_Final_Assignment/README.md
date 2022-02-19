# EE_3.07 Geodata Management Systems - Final Assignment WS2021/22

## 0. General Remarks

1. Due date is **2022-03-31**. 
1. You can withdraw from exam registration until **2022-02-28**.
1. You do not have to write a formal report but you have to sketch the steps you have taken to do the analyses. The code you are uploading as well as additional documentation has to **enable us to redo your work completely!** You must tell us which data you use and where to download it.
1. You can work in **groups of 1 - 3 students**. You have do the **group assignment** in our Moodle course: https://moodle.hochschule-rhein-waal.de/course/view.php?id=14379#section-6 <br> Assign to a group even if you **work alone**.
1. You have to **submit your work in a gitlab repository!** It is enough if **one member of the group uploads the group work**. <br>Create your own repo on the **University Gitlab server: https://git.hsrw.eu/**.
1. **USE THE FOLLWING REPO NAME:** `GeoData_WS2021_II_Final_<Group ID>`, (e.g. GeoData_WS2021_II_Final_Group_Z). <br>**Make it private but invite me to read it!**
1. Again: Make your **repo private** so others do not simply copy your work. **Grant read access to me** on your repository. **Stick to the naming convention!** Some students did not understand it the last semesters. This caused a lot of trouble. 
1. **I will clone your Gitlab repo at the end of deadline.** That will be the main basis of my assessment. **Stick to the naming convention and allow me to read your private repo!** If I cannot find your repo because of wrong naming or I cannot read it because you did not invite me for reading I will not be able to grade your work and **you will fail**. 
1. You have to use the GitLab repository to document your work. THIS IS MANDATORY! Use a `REAMDE.md` file (and more .md-files, if needed) to describe your work. Upload your Python/Jupyter scripts as well as QGIS projects but **do not add very large datasets** (e.g. no satellite images, excessive DTM tiles in XYZ format, etc.) to the repository. In case you use very large datasets **share the link to the data** in your documentation and/or your code. In case you you produce very large datasets tell us how and **enable us to reproduce your results** instead of flooding your repo with big data.
1. You have to **produce a presentation** (i.e. Powerpoint or similar) and upload it to your git repo. Describe the **four individual tasks**. See the pptx-template provided in this assignment repo. This includes a **self-assessment**. In case you work in groups each member has to provide a self-assessment. 
1. You have to **produce one video per group on your presentation** and upload it to your git repo. **All students must take part in their group's video presentation**. The video is to present the slides with your results. **Do not explain every detail** in the video, e.g. do not expalin how to execute your code line by line, etc. Just present each task, your methods, and your results. Refer (name or link) to your code files as well as QGIS projects in your slides such we can reproduce your work if we want.


## 1. Correlation of Mean Annual Temperature with Altitude in Bavaria

In the troposphere the mean annual temperature decreases approximately linearly with height. Verify this hypothesis by means of data in Bavaria. This federal state reveals the broadest range of topographic heights, from 100m to more than 2800m above Normal-Null (NN). 

You can start from the Jupyter Notebook `gnb0181_DWD_NRW_Annual_Temp_vs_Altitude_V001.ipynb`in the WS2021 geodata repo. 

**Sub-Task 1.1:** <br>
Plot the annual mean temperatures of **years 2017, 2018, and 2019** versus altitude for the DWD stations in Bavaria in one diagram (xy scatter plot). Use different colors for the different years. Use the **altitudes from the station description file** `KL_Jahreswerte_Beschreibung_Stationen.txt` for the data set `/annual/kl/historical/`.

**Sub-Task 1.2:** <br>
The DTM of Bavaria with 50m horizontal resolution in EPSG:25852 as GeoTiff (500 MB!) can be downloaded from here: <br>
http://www.geodaten.bayern.de/opendata/DGM50_UTM32/dgm50_epsg25832.tif

Create a decent map (including title, annotations, scales, legends, north arrow, graticule, CRS, data source references, etc.) with all DWD temperature stations in Bavaria which were active in the years of concern (2017, 2018, 2019). There are several ways to get a station layrer in QGIS. You can e.g. use Jupyter to create a CSV file from the DWD station description, import it to QGIS and limit it to Bavaria. Or you can create a geopackage with geopandas. Or you find other methods. Label the stations with their station id (number). 

Use the DTM as a map layer in the background. Try to find the digital administrative boundaries of Bavaria and overlay the disctrict boundaries as well as the boundary of the federal state. Crop the DTM to the boundary of Bavaria precisely. Use an appropriate color map to display the DTM as in topographic maps. Search the Internet for how to select and load suitable color maps in QGIS. Probably you still have to apply fine adjustments in the mapping of the colors to terrain elevation: Low lands green, higher elevations brown, the Alpine peaks white, and finally bluish for low land rivers, if possible. 

**Sub-Task 1.3:** <br>
Sample the DTM at the locations of the DWD stations.

Use the QGIS Processing Toolbox to do so. Use the dialog *Sample Raster Values* from the *Raster Analysis Toolbox*.
Selecting the menu item *Processing -> Toolbox* toggles the visibility of the Toolbox pane. From this select *Raster Analysis*.

Add another field to the DWD stations attribute table with the altitudes sampled from the DTM. Compare the original altitudes from the DWD station file to the heights derived from the DTM. Where and why are the strongest deviations? 

**Sub-Task 1.4:** <br>
Plot the mean annual temperatures versus the DTM heights for the DWD stations in Bavaria. Perform a **linear regression with numpy** to the data (not Excel!!!). How does the temperature vary with height according to your regression model, i.e. what is the temperature gradient (the slope of the regression line) in units K/m or °C/m?


## 2. DWD Precipitation Measurements in North Rhine-Westphalia (NRW): Create a Movie with QGIS Temporal Controller

**Spatio-Temporal Precipitation Anmination using PostGIS together with QGIS Temporal Controller**

Produce a rainfall video over a **7-day period** in 2021 that covers the heavy rains that led to the catastrophic flooding. The animation should cover all DWD stations in NRW with hourly precipitation. Create a point layer in QGIS showing the stations in NRW with time dependent precipitation rate data (mm per hour) in the attribute table. This layer has to come from a PostGIS **view**, which joins the **two tables** with 1) static station info including coordinates and 2) time dependent precipitation rates. Use the QGIS Temporal Controller to produce an animation. 

**Sub-Task 2.1: Create and fill your own geodatabase** <br> 
Create and fill your own geodatabase with DWD precipitation station data as well as hourly precipitation time series. Follow the **Jupyter Notebook tutorial** of [geo0930_PostGIS_Insert_DWD_Stations_and_TS](https://github.com/rolfbecker/opengeo/tree/main/geo0930_PostGIS_Insert_DWD_Stations_and_TS) (main notebook geo0930_PostGIS_DWD_Stations_and_TS_V002.ipynb) together with the respective **YouTube tutorial** [here](https://youtu.be/wvIkhZNfz6s)

(Remark: The general [opengeo repository](https://github.com/rolfbecker/opengeo) is under construction. I am using it to reorganize my teaching material independent from specific courses. It will be filled step by step.)

The last part of the video tutorial (from March 2021) is meanwhile outdated, because it explains how to produce an animation based on the QGIS TimaManager plugin. The **TimeManager plugin is deprecated!** The new way is to use the **QGIS Temporal Controller**, which is integrated in recent QGIS versions. I have no video on that, yet.

The following video shows an example of a precipitation animation generated with the QGIS TimeManager. It is meant to give you an idea about the activity.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=fdCQBbzyD84
" target="_blank"><img src="http://img.youtube.com/vi/fdCQBbzyD84/0.jpg" 
alt="QGIS Time Manager (deprecated): DWD Precipitation Data for NRW" width="300" border="10" /></a>

_Fig.: YouTube video showing the temporal evolution of DWD precipitation data in NRW for May 2019._

**Sub-Task 2.2: Add the PostGIS view v_stations_prec as a layer to your QGIS project**
After having finalized the tutorial above the geodatabase `geo` contains the two tables `dwd.prec`and `dwd.stations` as well as the view `v_stations_prec`. The view joins the two tables. Add the geo-enabled view as a PostGIS layer to your project.

**Sub-Task 2.3: Use the QGIS Temporal Controller to produce an animation** <br> 
Follow the tutorial https://www.qgistutorials.com/en/docs/3/animating_time_series.html on QGIS Temporal Controller to produce an animation.

The time period of data and animation, respectively, has to cover **7 days** with hourly resolution. You have to change the creation of the view in the Jupyter Notebook to extend the time span. The catastrophic rain event of 2021 (less than two days) should be roughly in the middle of the view's selected time interval.     

Import the NRW administrative boundary (vector layer) as a Web Feature Service (WFS). We discussed in class how to import and use the web services (WMS, WFS, WCS) provided by NRW (as part of opengeodata.nrw.de). Import the topographic map from the NRW WMS collection as the background map. 

Use the menu `view -> decorations` to add title, legend, scale, north arrow, time stamp, etc.

Save/export the created images and make a video from it. Add it to your gitlab repo.

## 3. Digitization: Burial Mounds in Uedemer Hochwald

<img src="images/Burial_Mounds.png" alt="Burial Mounds Map" width="600" border="10" /><br>
*Fig.: Burial mounds in Uedemer Hochwald.*

South west of the village Marienbaum (belongs to Xanten municipality) is the forest "Uedemer Hochwald" in which many burial mounds (German: Hügelgrab (sg.), Hügelgräber (pl.)) from our ancestors of the Hallstatt period (a Celtic culture between 850 and 450 BCE) can be found. The above picture shows a map section with some of the burial mounds indicated as grey dots. 
 
**Task 3.1:** <br> 
Georeference the picture of the map above. Start with the QGIS project `gdms0000_Burial_Mounds_Uedem_V001.qgz` in the assignment folder. Georeference the picture of the map by means of the QGIS Georeferencer together with the layer **DTK10**, the NRW topographic map in 1:10000, already imported from the NRW WMS server and added in the QGIS project. Use crossing forest trails, crossroads, road junctions and other features you can identify on DTK10 as land marks (aka ground control points, GCP) with known coordinates (can be read from the QGIS map canvas). Use EPSG:25832. Add the georeferenced map to the QGIS project.
 
**Task 3.2:** <br> 
Create a hillshade model from the DTM layer. Plot your georeferenced map partly transparent on top of the hillshade model. Compare. What do you observe? How good is the georeferenced map section showing the burial mounds? 

**Task 3.3:** <br> 
Use the DTM (not the hillshapde model!) and measure the typical mound heights relative to their direct environment/neighborhood (not the absolute height above sealevel!). What is their typical elvation in the landscape?

**Task 3.4:** <br> 
Study the hillshade model in direction East-North-East of the burial mounds area and search for weakly visible reectangular structures which are not paths. What do you observe? Do you have a guess about the origin of these patterns? Choose at least one of the structures, digitize it with a polygon and save it as a geopackage.

## 4. FREE EXERCISE

Do something exiting!



