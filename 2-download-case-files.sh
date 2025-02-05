#!/bin/bash -x

source ${1:-"./case.env"}

cpak=${2:-"cpak"}
# pass an arg: --skip-dependencies
cpakarg=$2

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

if test "$cpak" = "cp4ba" ; then
oc ibm-pak get -c file://${IBMPAK_HOME}/cert-kubernetes/scripts/airgap/cp4ba-case-to-be-mirrored-${CASE_BRANCH}.txt
else
oc ibm-pak get ${CASE_NAME} --version ${CASE_VERSION} ${cpakarg}
fi
