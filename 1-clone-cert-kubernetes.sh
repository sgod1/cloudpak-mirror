#!/bin/bash -x

source ./case.env

git clone -b $CASE_BRANCH https://github.com/icp4a/cert-kubernetes.git $IBMPAK_HOME/cert-kubernetes
