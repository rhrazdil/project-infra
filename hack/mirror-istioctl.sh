#!/bin/bash

# Usage
# ./sync-istioctl.sh 1.9.0,1.10.1

set -e

LOCAL_ISTIOCTL_DIR=istioctl-mirror

mkdir -o $LOCAL_ISTIOCTL_DIR

(
    cd $LOCAL_ISTIOCTL_DIR

    # Loop over comma-separated list of istio versions
    for i in $(echo $1 | sed "s/,/ /g")
    do
        curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$i sh -
    done
)

gsutil rsync -d -r $LOCAL_ISTIOCTL_DIR gs://$BUCKET_DIR
