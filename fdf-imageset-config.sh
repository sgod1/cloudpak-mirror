#!/bin/bash

# case.env [rhcat]

source ${1:-"./fdf.env"}
source ./registry.env

rhcat=${2:-"norhcat"}

#
# set ocp_version and ocp_full_version in case.env file
#
#export OCP_VERSION="4.17"
#export OCP_FULL_VERSION="4.17.9"

if test -z $OCP_VERSION -o -z $OCP_FULL_VERSION; then
echo set OCP_VERSION and OCP_FULL_VERSION in case.env file.
exit 1
fi

export OCP_PLATFORM="x86_64"
export PRODUCT_REPO="openshift-release-dev"
export RELEASE_NAME="ocp-release"
export OCP_RELEASE_IMAGE="quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_FULL_VERSION}-${OCP_PLATFORM}"

CASE_PATH="${IBMPAK_HOME}/.ibm-pak/data/mirror/${CASE_NAME}/${CASE_VERSION}"

#
# image set config
#

echo writing image-set-configuration to... "${CASE_PATH}/image-set-config.yaml"

mkdir -p $CASE_PATH

cat <<EOF > ${CASE_PATH}/image-set-config.yaml
kind: ImageSetConfiguration
apiVersion: mirror.openshift.io/v1alpha2
storageConfig:
  registry:
    imageURL: "${TARGET_REGISTRY}/isf-df-metadata:latest"
    skipTLS: true
mirror:
  additionalImages:
  - name: ${OCP_RELEASE_IMAGE}
  operators:
EOF
if test "$rhcat" = "rhcat"; then
cat <<EOF >> ${CASE_PATH}/image-set-config.yaml
  - catalog: registry.redhat.io/redhat/redhat-operator-index:v${OCP_VERSION}
    packages:
    - name: "redhat-oadp-operator"
    - name: "amq-streams"
EOF
fi
if test "$OCP_VERSION" = "4.14" -o "$OCP_VERSION" = "4.15"; then
cat <<EOF >> ${CASE_PATH}/image-set-config.yaml
  - catalog: icr.io/cpopen/isf-data-foundation-catalog:v${OCP_VERSION}
    packages:
    - name: "mcg-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "ocs-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-csi-addons-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-multicluster-orchestrator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odr-cluster-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odr-hub-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "ocs-client-operator"
      channels:
      - name: stable-${OCP_VERSION}
EOF
elif test "${OCP_VERSION}" = "4.16" -o "${OCP_VERSION}" = "4.17"; then
cat <<EOF >> ${CASE_PATH}/image-set-config.yaml
  - catalog: icr.io/cpopen/isf-data-foundation-catalog:v${OCP_VERSION}
    packages:
    - name: "mcg-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "ocs-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-csi-addons-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-multicluster-orchestrator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odr-cluster-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odr-hub-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "ocs-client-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "odf-prometheus-operator"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "recipe"
      channels:
      - name: stable-${OCP_VERSION}
    - name: "rook-ceph-operator"
      channels:
      - name: stable-${OCP_VERSION}
EOF
else
echo OCP version "$OCP_VERSION" is not supported by this script.
exit 1
fi

#
# image digest mirror set
#
echo writing image-digest-mirror-set to... "${CASE_PATH}/image-digest-mirror-set.yaml"
cat <<EOF > ${CASE_PATH}/image-digest-mirror-set.yaml
apiVersion: config.openshift.io/v1
kind: ImageDigestMirrorSet
metadata:
  labels:
    operators.openshift.org/catalog: "true"
  name: isf-fdf-idsp
spec:
  imageDigestMirrors:
  - mirrors:
    - ${TARGET_REGISTRY}/openshift4
    source: registry.redhat.io/openshift4
  - mirrors:
    - ${TARGET_REGISTRY}/redhat
    source: registry.redhat.io/redhat
  - mirrors:
    - ${TARGET_REGISTRY}/rhel9
    source: registry.redhat.io/rhel9
  - mirrors:
    - ${TARGET_REGISTRY}/rhel8
    source: registry.redhat.io/rhel8
  - mirrors:
    - ${TARGET_REGISTRY}/cp/df
    source: cp.icr.io/cp/df
  - mirrors:
    - ${TARGET_REGISTRY}/cpopen
    source: cp.icr.io/cpopen
  - mirrors:
    - ${TARGET_REGISTRY}/cpopen
    source: icr.io/cpopen
  - mirrors:
    - ${TARGET_REGISTRY}/cp/ibm-ceph
    source: cp.icr.io/cp/ibm-ceph
  - mirrors:
    - ${TARGET_REGISTRY}/lvms4
    source: registry.redhat.io/lvms4
  - mirrors:
    - ${TARGET_REGISTRY}/amq-streams
    source: registry.redhat.io/amq-streams
  - mirrors:
    - ${TARGET_REGISTRY}/oadp
    source: registry.redhat.io/oadp
  - mirrors:
    - ${TARGET_REGISTRY}/amq7
    source: registry.redhat.io/amq7
  - mirrors:
    - ${TARGET_REGISTRY}/ubi8
    source: registry.access.redhat.com/ubi8
  - mirrors:
    - ${TARGET_REGISTRY}/rhmtc
    source: registry.redhat.io/rhmtc
  - mirrors:
    - ${TARGET_REGISTRY}/ubi8
    source: registry.redhat.io/ubi8
EOF

#
# catalog sources
#

echo writing isf data foundation catalog source to... "${CASE_PATH}/catalogSource-cs-isf-data-foundation-catalog.yaml"
cat <<EOF > ${CASE_PATH}/catalogSource-cs-isf-data-foundation-catalog.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: cs-isf-data-foundation-catalog
  namespace: openshift-marketplace
spec:
  image: ${TARGET_REGISTRY}/cpopen/isf-data-foundation-catalog:v${OCP_VERSION}
  sourceType: grpc
EOF

echo writing redhat operator index catalog source to... "${CASE_PATH}/catalogSource-cs-redhat-operator-index.yaml"
cat <<EOF > ${CASE_PATH}/catalogSource-cs-redhat-operator-index.yaml
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: cs-redhat-operator-index
  #name: redhat-operators
  namespace: openshift-marketplace
spec:
  image: ${TARGET_REGISTRY}/redhat/redhat-operator-index:v${OCP_VERSION}
  sourceType: grpc
EOF

#echo writing isf catalog source to... "${CASE_PATH}/isf-catalog-source.yaml"
#cat <<EOF > ${CASE_PATH}/isf-catalog-source.yaml
#apiVersion: operators.coreos.com/v1alpha1
#kind: CatalogSource
#metadata:
#  name: isf-catalog
#  namespace: openshift-marketplace
#spec:
#  displayName: ISF Catalog
#  image: ${TARGET_REGISTRY}/cpopen/isf-operator-software-catalog:latest
#  publisher: IBM
#  sourceType: grpc
#  updateStrategy:
#    registryPoll:
#      interval: 30m0s
#EOF
