#/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Syntax: ./csv_reader_no_name.sh <my_program> <my csv>";
    echo "\tFor every item in the header, each value in a row will be mapped to the header and spaced delimited in its output";
    echo "\tExample 1 : /csv_reader_no_name.sh \"python my_program.py\" my_csv_no_header.csv >> my_run.sh; chmod ug+x my_run.sh; ./my_run.sh";
    echo "\tExample 2 : /csv_reader_no_name.sh ./my_program my_csv_no_header.csv >> my_run.sh; chmod ug+x my_run.sh; ./my_run.sh";
    echo "\tOutput: ➜  bash_csv_reader ./csv_reader_no_name.sh hihi my_csv_no_header.csv\n\t        >>> hihi 1 2 3\n\t        >>> hihi 4 5 6\n\t        >>> hihi 7 8 9";
    exit 1;
fi
declare -a FIRST_ROW=($(awk -F, 'BEGIN {OFS=" "} NR==1{ $1=$1; print $0;  }' $2))
declare -a VALS=($(awk -F, 'BEGIN {OFS=" "} { $1=$1; print $0;  }' $2))
offset=0;

# Iterate over a list of all arguments in the values section of the csv
for val_idx in `seq 0 $(( ${#VALS[*]}-1 ))`; do
    # Use modulus operator to decide which position in array is appropriate
    # (Based on the length of the first row)
    idx=$(( ${val_idx}%${#FIRST_ROW[*]} ));
    # Offset each argument by a space
    if [ ${idx} -eq 0 ] && [ ${val_idx} -ne ${idx} ]; then let offset+=1; fi
    # append to the argument array
    ARGS_ARR[$offset]="${ARGS_ARR[$offset]} ${VALS[$val_idx]}";
done;

# echo the submit script to redirect into array
for args_idx in `seq 0 $(( ${#ARGS_ARR[*]}-1 ))`; do
    echo $1 ${ARGS_ARR[${args_idx}]};
done;

