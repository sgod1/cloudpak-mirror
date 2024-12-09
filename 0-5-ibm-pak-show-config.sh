#!/bin/bash -x

source ./case.env

export PATH=./bin:$PATH

oc ibm-pak config
