#!/bin/bash -x

source ./case.env
source ./registry.env

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

# define filter variable in the case.env file
export baw_filter="ibmcp4baProd,ibmcp4baBAWImages,ibmcp4baFNCMImages,ibmcp4baBANImages,ibmcp4baBASImages,ibmcp4baAAEImages,ibmEdbStandard,ibmcp4baUMSImages,ibmcp4baPFSImages"
export wfps_filter="ibmcp4baProd,ibmcp4baAAEImages,ibmcp4baBASImages,ibmcp4baWFPSImages,ibmEdbStandard"

if test ! -z "$filter"; then
oc ibm-pak generate mirror-manifests $CASE_NAME $TARGET_REGISTRY --version $CASE_VERSION --filter $filter
else
oc ibm-pak generate mirror-manifests $CASE_NAME $TARGET_REGISTRY --version $CASE_VERSION
fi

