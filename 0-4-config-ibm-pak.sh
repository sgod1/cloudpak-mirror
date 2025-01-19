#!/bin/bash -x

source ${1:-"./case.env"}

export PATH=./bin:$PATH

oc ibm-pak config repo 'IBM Cloud-Pak OCI registry' -r oci:cp.icr.io/cpopen --enable

# oc-mirror, oc-image-mirror
oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS
