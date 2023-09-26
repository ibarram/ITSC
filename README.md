# Experimental dataset for classifying four levels of inter-turn short-circuit per phase in an induction motor.

<details><summary>Table of Contents</summary><p>
 
 * [Abstract](#abstract)

 * [Testbench](#testbench)
 
 * [License](#license)

</p></details><p></p>

## Abstract

The dataset contains the three-phase current signals measured from a squirrel-cage induction motor. The experimental tests were carried out for different fault levels in each winding phase; data was collected for a healthy state. The dataset consists of 13 categories: 12 inter-turn short-circuit faults per phase at 10%, 20%, 30%, and 40%, and healthy. Five repetitions were performed for each experimental condition; moreover, all measurements were collected in a steady state without load.

## Testbench

The dataset was acquired in the Laboratory of Electrical Engineering, Division of Engineering at Irapuato-Salamanca Campus of the University of Guanajuato, Mexico.

The testbench consists of a three-phase general-purpose squirrel-cage induction motor, Baldor CM3542 model, with a power of 0.75 hp, 208-230/460 AC voltage, and 1725 rpm at 60 Hz. The motor has 59 turns per pole with a double-star connection, and it was used to a nominal current of 3A at 230 VAC. 

![](doc/img/TestBed.png)

The faults are selected using a control panel with switches for choosing the phase and severity of the inter-turn short-circuit fault. The dataset consists of 13 categories: 12 inter-turn short-circuit faults per phase at 10%, 20%, 30%, and 40%, and healthy. The electrical current signals of the 3 phases were acquired using a transducer-type split-core current transformer SCT013 model connected to a NI-9215 Series I/O module.

The three phases were sampled simultaneously for 5 seconds, with a sampling rate of 1kHz. Five repetitions were performed for each severity level per phase and the healthy state, giving a total of [5x13=65] measurement files. The acquisitions were made under the steady state without load at 60Hz. The measurements were stored in .csv files of [5000x3] samples per class using LabVIEW. The raw dataset is named T_A”X”_B”X”_C”X”_R0_”Repetition”, where X represents the level of the fault, being 0 healthy conditions, 1-fault at 10%, 2-fault at 20%, 3-fault at 30% and 4-fault at 40%. For example, T_A0_B0_C1_R0_002 corresponds to phase C's second repetition of the inter-turn short-circuit fault at 10%.

The second folder of the dataset contains the files divided into folders according to the corresponding class. The files are named SC_A”X”_B”X”_C”X”_”repetition”; for example, SC_A0_B3_C0_004 corresponds to the fourth repetition of the fault in phase B at 30%.

Finally, a third folder provides the current signals filtered and pre-processed to localize the samples in a steady state to the fault. Therefore, from the [5000x3] samples of the raw data, it was cropped [1000x3] samples. Therefore, the size of this dataset is [classes x repetitions x (n_samples x n_phases)], giving [13 x 5 x (1000x3)] = [65000x3] samples in total.

## License

The MIT License (MIT) Copyright © 2017 Zalando SE, https://tech.zalando.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
