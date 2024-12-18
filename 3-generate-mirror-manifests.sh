#!/bin/bash -x

source ./case.env
source ./registry.env

export PATH=./bin:$PATH

export baw_filter="ibmcp4baProd,ibmcp4baBAWImages,ibmcp4baFNCMImages,ibmcp4baBANImages,ibmcp4baBASImages,ibmcp4baAAEImages,ibmEdbStandard,ibmcp4baUMSImages,ibmcp4baPFSImages"

export wfps_filter="ibmcp4baProd,ibmcp4baAAEImages,ibmcp4baBASImages,ibmcp4baWFPSImages,ibmEdbStandard"

oc ibm-pak generate mirror-manifests $CASE_NAME $TARGET_REGISTRY --version $CASE_VERSION --filter $baw_filter
