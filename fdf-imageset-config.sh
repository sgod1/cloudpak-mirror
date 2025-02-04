#!/bin/bash

source ${1:-"./fdf.env"}
source ../registry.env

export OCP_VERSION="4.17"
export OCP_FULL_VERSION="4.17.9"
export OCP_PLATFORM="x86_64"
export PRODUCT_REPO="openshift-release-dev"
export RELEASE_NAME="ocp-release"
export OCP_RELEASE_IMAGE="quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_FULL_VERSION}-${OCP_PLATFORM}"

CASE_PATH="${IBMPAK_CASE_HOME}/.ibm-pak/data/mirror/${CASE_NAME}/${CASE_VERSION}"

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
    - catalog: registry.redhat.io/redhat/redhat-operator-index:v${OCP_VERSION}
      packages:
      - name: "redhat-oadp-operator"
      - name: "amq-streams"
    - catalog: icr.io/cpopen/isf-data-foundation-catalog:v${OCP_VERSION}
      packages:
      - name: "mcg-operator"
      - name: "ocs-operator"
      - name: "odf-csi-addons-operator"
      - name: "odf-multicluster-orchestrator"
      - name: "odf-operator"
      - name: "odr-cluster-operator"
      - name: "odr-hub-operator"
      - name: "ocs-client-operator"
      - name: "odf-prometheus-operator"
      - name: "recipe"
      - name: "rook-ceph-operator"
EOF
