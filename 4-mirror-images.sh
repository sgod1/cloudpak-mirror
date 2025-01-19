#!/bin/bash -x

source ${1:-"./case.env"}

if test "$MIRROR_TOOLS" = "oc-mirror"; then
   ./4-mirror-oc-mirror.sh $1 $2

elif test "$MIRROR_TOOLS" = "oc-image-mirror"; then
   ./4-mirror-oc-image-mirror.sh $1 $2

else
   echo set MIRROR_TOOLS to oc-mirror or oc-image-mirror
   exit 1
fi
