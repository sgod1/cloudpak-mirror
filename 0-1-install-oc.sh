#!/bin/bash -x

# check download site for arch, os combination

os=`uname -o`
arch=`uname -m`

if test $os = "GNU/Linux" -a $arch = "x86_64"; then

   if test -f /etc/redhat-release; then
      rhel=`cat /etc/redhat-release | cut -d" " -f 4 | cut -d"." -f 1`

      if test $rhel = "8"; then
	 # rhel 8
         echo linux rhel8, x86_64
         octargz="openshift-client-linux-amd64-rhel8.tar.gz"
      else
	 # rhel 9
         echo linux rhel9, x86_64
         octargz="openshift-client-linux.tar.gz"
      fi

   else
      # linux other than rhel
      echo linux other than rhel, x86_64
      octargz="openshift-client-linux.tar.gz"
   fi

elif test $os = "Darwin" -a $arch = "x86_64"; then
   echo darwin, x86_64
   octargz="openshift-client-mac.tar.gz"

else
   echo update this script to check for $os and $arch combination
   exit 1
fi

if test -f ./$octargz; then
   rm ./$octargz
fi

mkdir -p ./bin
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/$octargz

tar xvf $octargz -C ./bin
chmod 755 ./bin/oc

mv ./$octargz ./bin
