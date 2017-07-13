#/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Syntax: ./csv_reader <my_program> <my csv>";
    echo "\tFor every item in the header, each value in a row will be mapped to the header and spaced delimited in its output";
    echo "\tExample 1 : /csv_reader.sh "python my_program.py" my_csv.csv >> my_run.sh; chmod ug+x my_run.sh; ./my_run.sh";
    echo "\tExample 2 : /csv_reader.sh ./my_program my_csv.csv >> my_run.sh; chmod ug+x my_run.sh; ./my_run.sh";
    echo "\tOutput: ➜  bash_csv_reader ./csv_reader.sh \"python my_program.py\" my_csv.csv\n\t        >>> python my_program.py arg1=1 arg2=2 arg3=3\n\t        >>> python my_program.py arg1=4 arg2=5 arg3=6\n\t        >>> python my_program.py arg1=7 arg2=8 arg3=9";
    exit 1;
fi

declare -a PARAMS=($(awk -F, 'BEGIN {OFS=" "} NR==1{ $1=$1; print $0;  }' $2  | sed 's/\"//g'))
declare -a VALS=($(awk -F, 'BEGIN {OFS=" "} NR>1{ $1=$1; print $0;  }' $2))
offset=0;

# Iterate over a list of all arguments in the values section of the csv
for val_idx in `seq 0 $(( ${#VALS[*]}-1 ))`; do
    # Use modulus operator to decide which position in array is appropriate
    # (Based on the length of the first row)
    idx=$(( ${val_idx}%${#PARAMS[*]} ));
    # Offset each argument by a space
    if [ ${idx} -eq 0 ] && [ ${val_idx} -ne ${idx} ]; then let offset+=1; fi
    # append to the argument array
    ARGS_ARR[$offset]="${ARGS_ARR[$offset]} ${PARAMS[$idx]}=${VALS[$val_idx]}";
done;

for args_idx in `seq 0 $(( ${#ARGS_ARR[*]}-1 ))`; do
    echo $1 ${ARGS_ARR[${args_idx}]};
done;
