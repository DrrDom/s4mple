#!/usr/bin/env bash

# $1 - path to dir with docked molecule dirs

scores=$(cat `find $1 -name "score" | sort` | awk '{print $6}')
dock=$(find $1 -name "score" | sort | cut -d'/' -f 2)
echo $dock
echo $scores
#paste $dock $scores | column -s $'\t' -t
