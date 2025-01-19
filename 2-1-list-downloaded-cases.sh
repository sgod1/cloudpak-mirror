#!/bin/bash

source ${1:-"./case.env"}

export PATH=./bin:$PATH

oc ibm-pak list --downloaded

