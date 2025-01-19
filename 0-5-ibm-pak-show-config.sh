#!/bin/bash -x

source ${1:-"./case.env"}

export PATH=./bin:$PATH

oc ibm-pak config
