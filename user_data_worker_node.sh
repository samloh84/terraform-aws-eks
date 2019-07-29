#!/bin/bash
set -e

${node_pre}
/etc/eks/bootstrap.sh \
--b64-cluster-ca '${cluster_auth_base64}' \
--apiserver-endpoint '${endpoint}' \
${bootstrap_extra_args} \
--kubelet-extra-args '${kubelet_extra_args}' \
'${cluster_name}'

${node_post}
