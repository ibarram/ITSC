[![version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/ibarram/ITSC/)
[![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/w/ibarram/ITSC)](https://github.com/ibarram/ITSC/)
[![GitHub discussions](https://img.shields.io/github/discussions/ibarram/ITSC)](https://github.com/ibarram/ITSC/discussions)
[![GitHub issues](https://img.shields.io/github/issues/ibarram/ITSC)](https://github.com/ibarram/ITSC/issues)
[![Readme-ES](https://img.shields.io/badge/README-Español-green.svg)](README_ES.md)
![Gitter](https://img.shields.io/gitter/room/ibarram/ITSC)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<br />
<div align="center">
  <a href="https://github.com/ibarram/ITSC">
    <img src="/doc/img/escudo-png.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">ITSC-dataset</h3>

  <p align="center">
    Experimental dataset for classifying four levels of inter-turn short-circuit per phase in an induction motor
    <br />
    <a href="https://github.com/ibarram/ITSC"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ibarram/ITSC">View Demo</a>
    ·
    <a href="https://github.com/ibarram/ITSC/issues">Report Bug</a>
    ·
    <a href="https://github.com/ibarram/ITSC/issues">Request Feature</a>
  </p>
</div>

<details><summary>Table of Contents</summary><p>
 
 * [Abstract](#abstract)

 * [Testbench](#testbench)

 * [Get the data](#get-the-data)

 * [Database](#database)

 * [Loading data](#loading-data)

 * [Implementations](#implementations)

 * [Benchmark](#benchmark)

 * [Publications](#publications)

 * [Contact](#Contact)

 * [Citing ITSC database](#citing-itsc-database)

 * [License](#license)

</p></details><p></p>

## Abstract

The dataset contains the three-phase current signals measured from a squirrel-cage induction motor. The experimental tests were carried out for different fault levels in each winding phase; data was collected for a healthy state. The dataset consists of 13 categories: 12 inter-turn short-circuit faults per phase at 10%, 20%, 30%, and 40%, and healthy. Five repetitions were performed for each experimental condition; moreover, all measurements were collected in a steady state without load.

## Testbench

The dataset was acquired in the Laboratory of Electrical Engineering, Division of Engineering at Irapuato-Salamanca Campus of the University of Guanajuato, Mexico.

The testbench consists of a three-phase general-purpose squirrel-cage induction motor, Baldor CM3542 model, with a power of 0.75 hp, 208-230/460 AC voltage, and 1725 rpm at 60 Hz. The motor has 59 turns per pole with a double-star connection, and it was used to a nominal current of 3A at 230 VAC. 


![](doc/img/TestBed.png)
Fig. 1.- Above is a photograph of the test bench used to generate the database. This setup provides a visual representation of our data collection process.


The faults are selected using a control panel with switches for choosing the phase and severity of the inter-turn short-circuit fault. The dataset consists of 13 categories: 12 inter-turn short-circuit faults per phase at 10%, 20%, 30%, and 40%, and healthy. The electrical current signals of the 3 phases were acquired using a transducer-type split-core current transformer SCT013 model connected to a NI-9215 Series I/O module.

The three phases were sampled simultaneously for 5 seconds, with a sampling rate of 1kHz. Five repetitions were performed for each severity level per phase and the healthy state, giving a total of [5x13=65] measurement files. The acquisitions were made under the steady state without load at 60Hz. The measurements were stored in .csv files of [5000x3] samples per class using LabVIEW. The raw dataset is named SC_A"X"_B”X"_C"X"\_"repetition”, where X represents the level of the fault, being 0 healthy conditions, 1-fault at 10%, 2-fault at 20%, 3-fault at 30% and 4-fault at 40%. For example, SC_A0_B0_C1_002 corresponds to phase C's second repetition of the inter-turn short-circuit fault at 10%.

The second folder of the dataset contains the files divided into folders according to the corresponding class. The files are named SC_A”X”_B”X”_C”X”\_"repetition"; for example, SC_A0_B3_C0_004 corresponds to the fourth repetition of the fault in phase B at 30%.

Finally, a third folder provides the current signals filtered and pre-processed to localize the samples in a steady state to the fault. Therefore, from the [5000x3] samples of the raw data, it was cropped [1000x3] samples. Therefore, the size of this dataset is [classes x repetitions x (n_samples x n_phases)], giving [13 x 5 x (1000x3)] = [65000x3] samples in total.

## Get the data

You can use direct links to download the dataset. The data is stored in the **csv** and **mat** formats.

| Name  | Description | Samples | Size | Link | MD5 Checksum|
| --- | --- |--- | --- |--- |--- |
| `RAW_Signals.zip`  | Raw data in CSV format  | [325,000x3] |4.7 MBytes | [Download](/dataset/RAW_Signals.zip)|`54914b0d0612d8ca7b4f6ab5169f5c0e`|
| `RAW_Signals_SF.zip`  | Raw data in CVS format arranged in folders | [325,000x3] |4.7 MBytes | [Download](/dataset/RAW_Signals_SF.zip)|`9102f70f8e4451c7d2da746a20dcf06a`|
| `Cropped_Signals_SF.zip`  | Cropped and preprocessed data in CSV fotmat  | [65,000x3] |1.7 MBytes | [Download](/dataset/Cropped_Signals_SF.zip)|`3c54a178e39de825c5296d9fd44dcd44`|
| `RAWData_ITSC.mat`  | Raw data in mat format  | [325,000x3]| 7.2 MBytes | [Download](/dataset/RAWData_ITSC.mat)|`514da2bad2f8dc2073f2338a2867b091`|
| `Data_ITSC.mat`  | Cropped and proprocessed data in mat format  | [65,000x3]| 1.5 MBytes | [Download](/dataset/Data_ITSC.mat)|`6040a140a61542e40288106e9245c895`|

Alternatively, you can clone this GitHub repository; the dataset appears under `dataset/`. This repository also contains some scripts for load and visualization.
   
```bash
git clone git@github.com:ibarram/ITSC.git
```

## Database

The database is presented in two formats. The first format uses MATLAB software, providing two .mat files referring to the induction motor's inter-turn short-circuit (ITSC) faults. The organization of the .mat files is illustrated in , where the values and number of samples change depending on which file is selected. The RAWData_ITSC.mat contains all samples collected without processing, contrary to the Data_ITSC.mat, which includes fewer samples due to pre-processing.


<picture>
 <source media="(prefers-color-scheme: dark)" srcset="doc/img/Fig1_info-Page-1b.png">
 <img alt="Display an illustration with a transparent background in light mode, and one with a white background in dark mode." src="doc/img/Fig1.png">
</picture>

Fig. 2.- Schematic representation of the data organized for MATLAB files.


The database was organized into folders for the second format provided, as depicted in Figure 2. Each folder includes the acquired measurements in files. The first folder, “RAW_Signals” contains the files for all the repetitions performed, named SC_AX_BX_CX_00Y.csv. According to the fault phase and severity level, a value between 0 and 4 is included, and the number of repetitions is indicated in “Y” as 1 to 5. For example, for the third repetition of a fault in phase A at 20%, the file is named SC_A2_B0_C0_003.csv. Moreover, the files in this folder contain all measurements acquired without processing.


<picture>
 <source media="(prefers-color-scheme: dark)" srcset="doc/img/Fig1_info-Page-2b.png">
 <img alt="Display an illustration with a transparent background in light mode, and one with a white background in dark mode." src="doc/img/Fig2.png">
</picture>

Fig. 3.- Schematic representation of folders.


The second and third folders, “RAW_Signals_SF” and “Cropped_Signals_SF” contain the .csv files corresponding to the phase, severity, and healthy state, as shown in Figure 2. The files in the subfolders are named SC_AX_BX_CX_00Y.  According to the fault phase and severity level, a value between 0 and 4 is included, and the number of repetitions is indicated in “Y” as 1 to 5. For example, for the second repetition of a fault in phase B at 30%, the file is named SC_A0_B3_002.csv.

In addition to the dataset, scripts to load and read the data are provided for MATLAB, Python, R, and C

## Loading data

Multiple scripts were created to efficiently load the [dataset](/dataset/). These scripts facilitate the loading of both raw and processed data, enabling work at different stages of analysis. The scripts have been developed in [MatLab](https://www.mathworks.com/products/matlab.html), [Python](https://www.python.org/), [R](https://www.r-project.org/), and [C](https://dl.acm.org/doi/10.1145/155360.155580).

### MatLab

### Python

### R

In the [load_data_Raw.r](/src/R/load_data_Raw.r) script, written in the [R programming language](https://www.r-project.org), the function `load_data_raw` is provided to streamline the loading of the dataset. Below is an example illustrating how to use this function:

```r
path_root="~/dataset"
db<-load_data_raw(path_root)
head(db)

        class rep fA fB fC     t         A        B         C
1 SC_A0_B0_C1   1  0  0 10 0.000  2.605652 1.510322 -4.665876
2 SC_A0_B0_C1   1  0  0 10 0.001 -0.167529 8.259827 -8.463958
3 SC_A0_B0_C1   1  0  0 10 0.002 -2.325757 5.854686 -8.046159
4 SC_A0_B0_C1   1  0  0 10 0.003 -5.714846 3.447656  2.986652
5 SC_A0_B0_C1   1  0  0 10 0.004 -7.311680 4.974165 -0.648386
6 SC_A0_B0_C1   1  0  0 10 0.005 -6.268270 2.720447 -2.884819
```

This repository includes a [dataset](/dataset/RAW_Signals.zip) comprised of raw signals for analysis.

The `path_root` variable points to the directory where the dataset with raw signals has been unpacked.
Using the `load_data_raw()` function, the dataset gets loaded into the `db` variable, formatted as a data frame.
To get a glimpse of the data, you can employ the `head(db)` function. This offers a look at the initial rows, providing a clear understanding of the data structure.

The `db` data frame incorporates nine columns, each signifying various attributes of the samples:

1. `class`: The designated class name of the sample.
2. `rep`: The iteration or repetition number associated with the experiment for the sample.
3. `fA`: Percentage of failure in phase A, linked to the `class` and `rep` of the sample.
4. `fB`: Percentage of failure in phase B, analogous to the `fA` description.
5. `fC`: Percentage of failure in phase C, consistent with the earlier failure percentage column descriptions.
6. `t`: Time vector tied to the class and rep, relevant for signals `A`, `B`, and `C`.
7. `A`: The signal of phase A, related to the `class`, `rep`, and timestamp `t`.
8. `B`: Reflecting the same structure as `A`, this represents the signal for phase B.
9. `C`: Signifying the signal for phase C, this follows the structuring of the preceding signal columns.

For those looking to query a specific signal, refer to the code below. As an example, if you wish to fetch the `SC_A0_B1_C0` class from the `2`th repetition and display `150` samples spanning all three phases, see the following example:"

```r
ind1<-db$class=="SC_A0_B1_C0"
ind2<-db$rep==2
tmp<-db$t[ind1&ind2]
pA<-db$A[ind1&ind2]
pB<-db$B[ind1&ind2]
pC<-db$C[ind1&ind2]
nmi<-1000
nmf<-1150
plot(tmp[nmi:nmf], pA[nmi:nmf], type = "l", col = "blue", lwd = 2, main = "ITSC", xlab = "Time", ylab = "Amplitude")
lines(tmp[nmi:nmf], pB[nmi:nmf], col = "red")
lines(tmp[nmi:nmf], pC[nmi:nmf], col = "green")
legend("topright", inset=c(0, 0), legend=c("A","B", "C"), pch=c('-','-','-'),col=c("blue","red","green"), title="Phases")
```


![](doc/img/Fig3.gif)

Fig. 3. Plot of the raw signal for repetition `2` of the `SC_A0_B1_C0` class, showcasing `150` continuous samples


In the script [load_data_Cropped_SF.R](/src/R/load_data_Cropped_SF.R), written in the [R programming language](https://www.r-project.org), you'll find the function "load_data_cropped" which facilitates the loading of the dataset. Here's an example of how to use this function:

```r
path_root="~/dataset"
db<-load_data_cropped(path_root)
head(db)


        class rep fA fB fC     t        A          B          C
1 SC_A0_B0_C1   1  0  0 10 0.000 2.520547 -2.3864827  0.3669159
2 SC_A0_B0_C1   1  0  0 10 0.001 3.071474 -1.8815071 -0.7766104
3 SC_A0_B0_C1   1  0  0 10 0.002 3.191175 -1.1129394 -1.8108357
4 SC_A0_B0_C1   1  0  0 10 0.003 2.862758 -0.1886192 -2.5904976
5 SC_A0_B0_C1   1  0  0 10 0.004 2.132251  0.7617812 -3.0061320
6 SC_A0_B0_C1   1  0  0 10 0.005 1.102164  1.6050195 -2.9994312
```

In this repository, the [dataset](/dataset/Cropped_Signals_SF.zip) containing segmented signals is loaded for analysis.

* The variable `path_root` represents the directory where the dataset containing the cropped signals has been extracted.
* By using the `load_data_cropped()` function, the dataset is loaded into a variable named `db`, which is structured as a data frame.
* To preview the contents of this data frame, the `head(db)` function can be used. This will display the initial rows of the data, providing insight into its structure.

The data frame `db` contains nine columns, each representing different characteristics of the samples. These columns are:

1. `class`: The class name associated with the sample.
2. `rep`: The iteration number of the experiment for a given sample.
3. `fA`: The percentage of failure in phase A, corresponding to the `class` and `rep` of the sample.
4. `fB`: The percentage of failure in phase B, analogous to the `fA` column's description.
5. `fC`: The percentage of failure in phase C, in line with the previous failure percentage columns.
6. `t`: Time vector associated with the `class` and `rep`, relevant to signals `A`, `B`, and `C`.
7. `A`: Signal for phase A of the sample, corresponding to the `class`, `rep`, and time `t`.
8. `B`: Similar to `A`, this represents the signal for phase B.
9. `C`: This column contains the signal for phase C, following the pattern of the previous signal columns.

To query a specific signal, you can use the code provided below. For instance, if you aim to retrieve the `SC_HLT` class for the `4` repetition and wish to display `150` samples across all three phases, follow this example:

```r
ind1<-db$class=="SC_HLT"
ind2<-db$rep==4
tmp<-db$t[ind1&ind2]
pA<-db$A[ind1&ind2]
pB<-db$B[ind1&ind2]
pC<-db$C[ind1&ind2]
nm<-150;
plot(tmp[1:nm], pA[1:nm], type = "l", col = "blue", lwd = 2, main = "ITSC", xlab = "Time", ylab = "Amplitude")
lines(tmp[1:nm], pB[1:nm], col = "red")
lines(tmp[1:nm], pC[1:nm], col = "green")
legend("topright", inset=c(0, 0), legend=c("A","B", "C"), pch=c('-','-','-'),col=c("blue","red","green"), title="Phases")
```


![](doc/img/Fig4.gif)

Fig. 4. Plot of the preprocessed signal for repetition `4` of the `SC_HLT` class, showcasing `150` continuous samples


### C

<picture>
 <source media="(prefers-color-scheme: dark)" srcset="doc/img/struct_2.png">
 <img alt="Display an illustration with a transparent background in light mode, and one with a white background in dark mode." src="doc/img/struct_1.png">
</picture>

Fig. 5 Graphic representation of the `db` strcuture containing the dataset ITS.C

## Benchmark

Feel free to submit your benchmark by creating a new issue, and we'll display your results here. Before proceeding, ensure your benchmark doesn't already exist on this list. For further information, refer to our contributor guidelines.

The table below showcases the benchmarks submitted by contributors. Please note that we haven't verified these results. You're encouraged to validate these results using the provided code from the submitter. Differences in test accuracy might arise from variations in training parameters, the validation process, and other factors. To amend any information in this table, simply raise a new issue.

| Preprocessing | Feature extraction | Classifier | Number of classes | Accurary | Healthy | Failure percentage | Precision (Phase A) | Precision (Phase B) | Precision (Phase C) | Submitter | Code | DOI |
| --- | --- | --- | --- | --- | --- | --- | --- |  --- | --- | --- | --- | --- |
| Butterworth filter | Quaternion | Boosting Decision Tree | 13 | 0.7948±0.0495 | 0.9000±0.2000 | <p> 10% <p> 20% <p> 30% <p> 40% | <p> 0.5200±0.3730 <p> 0.7750±0.3945 <p> 0.7667±0.3958 <p> 0.4600±0.4737 | <p> 0.7750±0.3250 <p> 0.9000±0.1225 <p> 0.9500±0.1000 <p> 1.0000±0.0000 <p> | <p> 0.7137±0.3633 <p> 0.9000±0.2000 <p> 0.7417±0.1953 <p> 0.7250±0.2077 <p> | [@JuanJCC75](https://github.com/JuanJCC75) | [:link:](/src/benchmark/) | [:link:](https://doi.org/10.1016/j.measurement.2023.113680) |
| Butterworth filter | Quaternion | Boosting Decision Tree | 5 | 0.9267±0.0858 | 0.8000±0.4000 | <p> 10% <p> 20% <p> 30% <p> 40% | <p> 0.7950±0.2150 <p> 1.0000±0.0000 <p> 1.0000±0.0000 <p> 1.0000±0.0000 <p> | --- | --- | [@JuanJCC75](https://github.com/JuanJCC75) | [:link:](/src/benchmark/) | [:link:](https://doi.org/10.1016/j.measurement.2023.113680) |
| Butterworth filter | Quaternion | Boosting Decision Tree | 5 | 0.9267±0.0966 | 0.9200±0.1600 | <p> 10% <p> 20% <p> 30% <p> 40% | --- | <p> 0.9000±0.3000 <p> 0.8500±0.3202 <p> 0.9500±0.1500 <p> 1.0000±0.0000 <p> | --- | [@JuanJCC75](https://github.com/JuanJCC75) | [:link:](/src/benchmark/) | [:link:](https://doi.org/10.1016/j.measurement.2023.113680) |
| Butterworth filter | Quaternion | Boosting Decision Tree | 5 | 0.9100±0.1021 | 0.6000±0.4637 | <p> 10% <p> 20% <p> 30% <p> 40% | --- | --- | <p> 0.7250±0.3345 <p> 1.0000±0.0000 <p> 1.0000±0.0000 <p> 1.0000±0.0000 <p> | [@JuanJCC75](https://github.com/JuanJCC75) | [:link:](/src/benchmark/) | [:link:](https://doi.org/10.1016/j.measurement.2023.113680) |

## Implementations

### Quaternion Signal Analysis

### Complex Signal Analysis

## Publications

Publications from the scientific community that use the ITSC dataset:

1. J.-J. Cardenas-Cornejo, M.-A. Ibarra-Manzano, A. Gonzalez-Parada, R. Castro-Sanchez, D.-. Almanza-Ojeda, "Classification of inter-turn short-circuit faults in induction motors based on quaternion analysis", Measurement, Vol. 222, pages 1-10, 2023, 113680, ISSN: 0263-2241, DOI: 10.1016/j.measurement.2023.113680

## Contact

[Dra. D.-L. Almanza-Ojeda](mailto:dora.almanza@ugto.mx?subject=[GitHub]%20ITSC%20dataset) - [ORCID: 0000-0002-3373-0929](https://orcid.org/0000-0002-3373-0929) - [SCOPUS: 13608761000](https://www.scopus.com/authid/detail.uri?authorId=13608761000) 

[Dr. M.-A. Ibarra-Manzano](mailto:ibarram@ugto.mx?subject=[GitHub]%20ITSC%20dataset) - [ORCID: 0000-0003-4317-0248](https://orcid.org/0000-0003-4317-0248) - [SCOPUS: 15837259000](https://www.scopus.com/authid/detail.uri?authorId=15837259000)

[M.I. J.-J. Cardenas-Cornejo](mailto:jj.cardenascornejo@ugto.mx?subject=[GitHub]%20ITSC%20dataset) - [ORCID: 0000-0001-6847-4059](https://orcid.org/0000-0001-6847-4059) - [SCOPUS: 57218545341](https://www.scopus.com/authid/detail.uri?authorId=57218545341)

[Dr. A. Gonzalez-Parada](mailto:gonzaleza@ugto.mx?subject=[GitHub]%20ITSC%20dataset) - [ORCID: 0000-0003-3473-1349](https://orcid.org/0000-0003-3473-1349) - [SCOPUS: 36011661100](https://www.scopus.com/authid/detail.uri?authorId=36011661100)

[Dr. R. Castro-Sanchez](mailto:castro@ugto.mx?subject=[GitHub]%20ITSC%20dataset) - [ORCID: 0000-0002-4072-4105](https://orcid.org/0000-0002-4072-4105) - [SCOPUS: 6508110285](https://www.scopus.com/authid/detail.uri?authorId=6508110285)

Project Link: [ITSC](https://github.com/ibarram/ITSC)

## Citing ITSC database

If you use ITSC database in a scientific publication, we would appreciate references to the following paper:

**Juan-Jose Cardenas-Cornejo, Mario-Alberto Ibarra-Manzano, Adrián González-Parada, Rogelio Castro-Sanchez, Dora-Luz Almanza-Ojeda, Classification of inter-turn short-circuit faults in induction motors based on quaternion analysis, Measurement, Volume 222, 2023, 113680, ISSN 0263-2241, [DOI:10.1016/j.measurement.2023.113680](https://doi.org/10.1016/j.measurement.2023.113680)**

Biblatex entry:
```latex
@article{CARDENASCORNEJO2023113680,
title = {Classification of inter-turn short-circuit faults in induction motors based on quaternion analysis},
journal = {Measurement},
volume = {222},
pages = {113680},
year = {2023},
issn = {0263-2241},
doi = {https://doi.org/10.1016/j.measurement.2023.113680},
url = {https://www.sciencedirect.com/science/article/pii/S0263224123012447},
author = {Juan-Jose Cardenas-Cornejo and Mario-Alberto Ibarra-Manzano and Adrián González-Parada and Rogelio Castro-Sanchez and Dora-Luz Almanza-Ojeda},
keywords = {Inter-turn short-circuit faults, Quaternion analysis, Multiclass dataset, Squirrel cage induction motors},
abstract = {Short-circuit in three-phase engines are highly destructive faults, which overheat and damage internal elements reducing efficiency and lifetime. New multi-class approaches are best trained with measurements from three-phase motors instrumented with short-circuit faults because it offers natural and physical signal behavior. This work overcomes the lack of datasets by acquiring current signals from an instrumented induction motor to create a dataset of inter-turn short-circuit (ITSC) faults at four levels per phase. The dataset generated consists of 13 categories with five repetitions per trial for a squirrel cage motor induction. The proposed classification method is based on quaternions that simultaneously model the three-phase signals as pure quaternions. Three statistical features are extracted from quaternions, and a decision tree classifier is trained per feature. Thereby, a boosting scheme is used to calculate the resulting category. Boosting method improves the classification results of decision tree models, showing fast, accurate, and robust performance.}
}
```

## License

The MIT License (MIT) Copyright © 2017 Zalando SE, https://tech.zalando.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
