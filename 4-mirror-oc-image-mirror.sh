#!/bin/bash -x

source ${1:-"./case.env"}
source "./registry.env"

if test "$2"="tofile"; then
echo "oc image mirror to a file not implemented"
exit 1

elif test="$2"="fromfile"; then
echo "oc image mirror from a file not implemented"
exit 1
fi

export PATH=./bin:$PATH

oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS

# you can pass --insecure flag to this command
oc image mirror -f $IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/images-mapping.txt --filter-by-os '.*' -a $REGISTRY_AUTH_FILE --skip-multiple-scopes --max-per-registry=1
