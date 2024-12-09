#!/bin/bash -x

OC_MIRROR_TAR="oc-mirror.tar.gz"

if test -f ${OC_MIRROR_TAR}; then
   echo removing existing oc-mirror archive
   rm ${OC_MIRROR_TAR}
fi

wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/${OC_MIRROR_TAR}

mkdir -p ./bin
tar xvf ${OC_MIRROR_TAR} -C ./bin
mv ${OC_MIRROR_TAR} ./bin

chmod 755 ./bin/oc-mirror

