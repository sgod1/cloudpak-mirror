#!/bin/bash -x

source ${1:-"./case.env"}
source "./registry.env"

if test "$2"="tofile"; then
filearg="file://${IBMPAK_HOME}"
fi

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

if test ! -z $filter; then
filterarg="--filter $filter"
fi

if test ! -z $filearg; then
oc ibm-pak generate mirror-manifests $CASE_NAME $filearg --version $CASE_VERSION --final-registry $TARGET_REGISTRY $filterarg

else
oc ibm-pak generate mirror-manifests $CASE_NAME $TARGET_REGISTRY --version $CASE_VERSION $filterarg
fi

