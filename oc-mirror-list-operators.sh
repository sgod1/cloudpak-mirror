#!/bin/bash

source ${1:-"./case.env"}
source "./registry.env"

if test -z $OCP_VERSION -o -z $OCP_FULL_VERSION; then
echo set OCP_VERSION and OCP_FULL_VERSION in case.env file.
exit 1
fi

export PATH=./bin:$PATH

set -x

oc mirror list operators --catalog $TARGET_REGISTRY/cpopen/isf-data-foundation-catalog:v$OCP_VERSION
oc mirror list operators --catalog $TARGET_REGISTRY/redhat/redhat-operator-index:v${OCP_VERSION}
#oc mirror list operators --catalog icr.io/cpopen/isf-data-foundation-catalog:v$OCP_VERSION

