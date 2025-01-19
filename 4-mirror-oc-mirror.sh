#!/bin/bash -x

source ${1:-"./case.env"}
source ${2:-"./registry.env"}

VER=$CASE_LATEST_VERSION
if test -z $VER; then
   VER=$CASE_VERSION
fi

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

# you can pass --insecure flag to this command
oc mirror --config $IBMPAK_HOME/data/mirror/$CASE_NAME/$CASE_VERSION/image-set-config.yaml $TARGET_REGISTRY --dest-skip-tls --max-per-registry=6
