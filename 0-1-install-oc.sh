#!/bin/bash -x

# check download site for arch, rhel version binary

octargz="openshift-client-linux-amd64-rhel8.tar.gz"

if test -f ./$octargz; then
   rm ./$octargz
fi

mkdir -p ./bin
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/$octargz

tar xvf $octargz -C ./bin
chmod 755 ./bin/oc

mv ./$octargz ./bin
