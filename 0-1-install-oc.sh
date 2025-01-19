#!/bin/bash -x

# check download site for arch, os combination

os=`uname -o`
arch=`uname -m`

if test $os == "GNU/Linux" && test $arch == "x86_64"; then
   octargz="openshift-client-linux.tar.gz"

elif test $os == "Darwin" && test $arch == "x86_64"; then
   octargz="openshift-client-mac.tar.gz"

else
   echo update this script to check for $os and $arch combination
   exit 1
fi

#octargz="openshift-client-linux-amd64-rhel8.tar.gz"

if test -f ./$octargz; then
   rm ./$octargz
fi

mkdir -p ./bin
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/$octargz

tar xvf $octargz -C ./bin
chmod 755 ./bin/oc

mv ./$octargz ./bin
