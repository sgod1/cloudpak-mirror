#!/bin/bash

source ./case.env

export PATH=./bin:$PATH

oc ibm-pak list --downloaded

