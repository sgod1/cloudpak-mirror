#!/bin/bash -x

source ./case.env

export PATH=./bin:$PATH

oc ibm-pak config repo 'IBM Cloud-Pak OCI registry' -r oci:cp.icr.io/cpopen --enable

oc ibm-pak config mirror-tools --enabled oc-mirror
#oc ibm-pak config mirror-tools --enabled oc-image-mirror
