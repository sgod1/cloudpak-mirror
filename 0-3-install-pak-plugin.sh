#!/bin/bash -x

source ./case.env

# https://github.com/IBM/ibm-pak/releases
export IBMPAK_RELEASE="v1.16.2"

IBMPAK_ARCHIVE="oc-ibm_pak-linux-amd64.tar.gz"

if test -f ${IBMPAK_ARCHIVE}; then
   echo removing existing ibm pak archive
   rm ${IBMPAK_ARCHIVE}
fi

wget https://github.com/IBM/ibm-pak/releases/download/${IBMPAK_RELEASE}/${IBMPAK_ARCHIVE}

mkdir -p ./bin
tar xvf ./oc-ibm_pak-linux-amd64.tar.gz -C ./bin

chmod 755 ./bin/oc-ibm_pak
mv ${IBMPAK_ARCHIVE} ./bin

