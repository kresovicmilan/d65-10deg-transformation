# Testing of D65/10deg transformation

This repository contains the code for the reformatting of printers reflectance measurements, calculating the LAB values and storing the LAB values in the right format.

## Download instructions

These commands will get you a copy of project for dev and testing purposes
```
$ git clone https://github.com/kresovicmilan/d65-10deg-transformation.git
```

## Prerequisites

To successfully run the application on your local machine please install following software

* Matlab R2020a v9.8 [*(download link)*](https://se.mathworks.com/products/matlab.html)
* Python v3.6.12 - with following libraries:
  * Numpy v1.19.2
  * Pandas v0.23.4

## Configuration

Place your measurnments folder in the same folder where is *transformation.py* file.

## Steps

Do the following steps to get correctly formatted file with LAB values.

### Step 1

Go to *transformation.py* and change the **FILE_PATH** variable to the path of your file that contains the reflectance measurements.

***Note:*** If measurements are done in RGB, the file name should contain substring "RGB" or "rgb"

### Step 2

Open Matlab and change your current directory to the directory where is *reflectance_conversion.m* file. Run the following code:

```
[XYZ, LAB_not_scaled] = reflectance_conversion(filename, measurement_condition, obs, type_of_test_chart, name_of_the_printer);
```

* **filename** - contains the name of the transformed file - e. g. ```"somename_Transformed.txt"```
* **measurement_condition** - contains the Illuminant and the viewing angle - e. g. ```'d50_31'```, ```'d65_64'```, ```'a_31'```, etc.
* **obs** - contains the Illuminant and the viewing angle of what you would like your LAB values to be converted to - e. g. same as *measurement__condition*
* **type_of_test_chart** - contains type of the test chart - supported values: ```'eci2002v_cmyk'```, ```'tc918_rgb'``` or ```'eci2002r_cmyk'```
* **name_of_the_printer** - e. g. ```'Durst'```, ```'HP'```, etc.

### Step 3

Go to the *format_file.py* and change **MATLAB_FILE_PATH** which should contain the file path of calculated LAB measurements from *step 2*, and change **TRANSFORMED_FILE_PATH** which should contain the file path of the transformed file from *step 1*.

If everything is done properly, generated file will be stored in *3GeneratedFiles* folder.
