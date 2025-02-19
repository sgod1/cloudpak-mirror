#!/bin/bash -x

source ${1:-"./case.env"}
source "./registry.env"

#
# invocation: mirror-oc-mirror.sh [case.env ["tofile"|"fromfile"] ]
#

#
# second parameter is "tofile" or "fromfile"
#
if test "$2" = "tofile"; then
      file="file://${IBMPAK_HOME}"

elif test "$2" = "fromfile"; then
      seqfile=${3:-"mirror_seq1_000000.tar"}
      fromfile=${IBMPAK_HOME}/${seqfile}
fi

VER=$CASE_LATEST_VERSION
if test -z $VER; then
   VER=$CASE_VERSION
fi

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

if test ! -z $fromfile; then

   if test -f $fromfile; then
      oc mirror --dest-skip-tls --from=${fromfile} docker:${TARGET_REGISTRY}

   else
      echo mirror file $fromfile not found...
      exit 1
   fi

else
   target=${file:-"docker://$TARGET_REGISTRY"}

   if test ! -z "$file"; then
      echo mirror from the mothership to directory $file
   else
      echo mirror from the mothership to private docker registry $TARGET_REGISTRY
   fi

   # you can pass --insecure flag to this command
   oc mirror --config $IBMPAK_HOME/.ibm-pak/data/mirror/${CASE_NAME}/"${VER}"/image-set-config.yaml $target --dest-skip-tls --max-per-registry=6
fi

