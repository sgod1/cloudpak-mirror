#!/bin/bash -x

source ./case.env

# https://github.com/IBM/ibm-pak/releases
export IBMPAK_RELEASE="v1.16.2"

os=`uname -o`
arch=`uname -m`

if test $os == "GNU/Linux" && test $arch == "x86_64"; then
   IBMPAK_ARCHIVE="oc-ibm_pak-linux-amd64.tar.gz"
   IBMPAK_BIN="oc-ibm_pak-linux-amd64"

elif test $os == "Darwin" && test $arch == "x86_64"; then
   IBMPAK_ARCHIVE="oc-ibm_pak-darwin-amd64.tar.gz"
   IBMPAK_BIN="oc-ibm_pak-darwin-amd64"

else
   echo update this script to check for $os and $arch combination
   exit 1
fi

if test -f ${IBMPAK_ARCHIVE}; then
   echo removing existing ibm pak archive
   rm ${IBMPAK_ARCHIVE}
fi

wget https://github.com/IBM/ibm-pak/releases/download/${IBMPAK_RELEASE}/${IBMPAK_ARCHIVE}

mkdir -p ./bin
tar xvf ./$IBMPAK_ARCHIVE -C ./bin

cp ./bin/$IBMPAK_BIN ./bin/oc-ibm_pak

chmod 755 ./bin/oc-ibm_pak
mv ${IBMPAK_ARCHIVE} ./bin

