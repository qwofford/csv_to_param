# Easy CSV Reader for bash

HPC scripts often benefit from parameterized scripts. Parameterized scripts are easily expressed in csv format. There are two ways to give parameters meaning:

* Argument ordering 
* Argument naming.

This tool covers both cases in two scripts.

### If you are generating parameterized scripts from a csv file **with** headers, use **csv_reader.sh**

	➜  bash_csv_reader git:(master) ✗ cat my_csv.csv 
	>>> arg1,arg2,arg3
	>>> 1,2,3
	>>> 4,5,6
	>>> 7,8,9

	➜  bash_csv_reader git:(master) ✗ ./csv_reader.sh "python my_script" my_csv.csv 
	>>> python my_script arg1=1 arg2=2 arg3=3
	>>> python my_script arg1=4 arg2=5 arg3=6
	>>> python my_script arg1=7 arg2=8 arg3=9

To execute this script, I recommend:

	./csv_reader.sh "python my_script" my_csv.csv > my_script.sh; chmod ug+x my_script.sh; ./my_script.sh;

### If you are generating parameterized scripts from a csv file **without** headers, use **csv_reader_no_name.sh**

	➜  bash_csv_reader git:(master) ✗ cat my_csv_no_header.csv 
	>>> 1,2,3
	>>> 4,5,6
	>>> 7,8,9

	➜  bash_csv_reader git:(master) ✗ ./csv_reader_no_name.sh "python my_script" my_csv_no_header.csv 
	>>> python my_script 1 2 3
	>>> python my_script 4 5 6
	>>> python my_script 7 8 9

To execute this script, I recommend:

	./csv_reader_no_name.sh "python my_script" my_csv_no_header.csv > my_script.sh; chmod ug+x my_script.sh; ./my_script.sh
