#!/usr/bin/env bash

function timing {
    for file in `ls optimal/*.$1 *.$1 | sort -V`; do
        echo $file | sed -e 's/\..*//'
        (time -p $2 $file) 2>&1 | grep -vE '^(user|sys)' | sed -e 's/^real //'
    done | paste - - - > time-$1.txt
}

timing pl perl
timing py python
timing js node
timing R  Rscript
