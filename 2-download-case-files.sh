#!/bin/bash -x

source ./case.env

export PATH=./bin:$PATH

oc ibm-pak get -c file://$IBMPAK_HOME/cert-kubernetes/scripts/airgap/cp4ba-case-to-be-mirrored-$CASE_BRANCH.txt

