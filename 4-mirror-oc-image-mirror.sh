#!/bin/bash -x

source ${1:-"./case.env"}
source ${2:-"./registry.env"}

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

# you can pass --insecure flag to this command
oc image mirror -f $IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/images-mapping.txt --filter-by-os '.*' -a $REGISTRY_AUTH_FILE --skip-multiple-scopes --max-per-registry=1
