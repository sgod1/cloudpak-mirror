#!/bin/bash -x

source ./case.env
source ./registry.env

export PATH=./bin:$PATH

oc ibm-pak generate mirror-manifests $CASE_NAME $TARGET_REGISTRY --version $CASE_VERSION

