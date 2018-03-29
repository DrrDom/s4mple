#!/usr/bin/env bash

# $1 - path to dir with docked molecule dirs
# $2 - path to ref.mol2 of the binding pocket
# $3+ - numbers of dock dirs to unpack (optional)

function contains {
  res=0
  for v in ${*:2}
  do
    if [[ $1 == $v ]]; then
      res=1
    fi
  done
  echo $res
}

for d in $1/dock*/
do
  if [[ $# -ge 3 ]]; then
    num=$(echo ${d::-1} | egrep -o '[[:digit:]]*$' | head)
    if [[ $(contains $num ${*:3}) == 0 ]]; then
      continue
    fi
  fi
#  echo $d
  # remove all best mol2 files and pocket mol2 file (ref.mol2)
  rm $d/*mol2
  # unzip docking output
  gunzip $d/diverse.out.gz
  gunzip $d/docked.out.gz
  # link protein binding pocket
  ln -s `readlink -e $2` $d
  # get the best pose
  $SCRIPT_DIR/$MACHTYPE/samplingN -i loc=$d -f parm_ff_fit -e strat=filter:pop_in=docked.out:`cat distRefs`
done
