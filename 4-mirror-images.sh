#!/bin/bash -x

source ./case.env
source ./registry.env

export PATH=./bin:$PATH

# you can pass --insecure flag to this command

# pass --filter option to mirror subset of images
# filter for baw: --filter ibmcp4baProd,ibmcp4baBASImages,ibmcp4baAAEImages,ibmEdbStandard

oc image mirror -f $IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/images-mapping.txt --filter-by-os '.*' -a $REGISTRY_AUTH_FILE --skip-multiple-scopes --max-per-registry=1
