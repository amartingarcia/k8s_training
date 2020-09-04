#!/bin/bash
set -e
set -o pipefail
​
# Add user to k8s using service account, and create RBAC with full access to the deffined namespace
if [[ -z "$1" ]] || [[ -z "$2" ]]; then
 echo "usage: $0 <service_account_name> <namespace>"
 exit 1
fi
​
DEPENDENCIES=("kubectl" "jq")
SERVICE_ACCOUNT_NAME=$1
NAMESPACE="$2"
TARGET_FOLDER="/tmp/kube"
KUBECFG_FILE_NAME="${TARGET_FOLDER}/k8s-config-${SERVICE_ACCOUNT_NAME}-${NAMESPACE}"
​
GREEN='\033[0;32m' # set green color output
RED='\033[0;31m' # set green color output
NC='\033[0m' # no color
​
check_required_software() {
    echo "Checking dependencies..."
    for i in ${DEPENDENCIES[@]}
    do
        echo "... Checking dependency: $i"
        if ! type $i > /dev/null 2>&1; then
            printf "${RED}The following software is required: $i ${NC}"
            exit 1;
        fi
    done
    printf "${GREEN}Done${NC}"
}
create_target_folder() {
    echo -e "\\nCreating target directory to hold files in ${TARGET_FOLDER}..."
    mkdir -p "${TARGET_FOLDER}"
    printf "${GREEN}Done${NC}"
}
​
create_service_account() {
    echo -e "\\nCreating a service account: ${SERVICE_ACCOUNT_NAME}"
    kubectl -n ${NAMESPACE} create sa "${SERVICE_ACCOUNT_NAME}"
    printf "${GREEN}Done${NC}"
}
​
get_secret_name_from_service_account() {
    echo -e "\\nGetting secret of service account ${SERVICE_ACCOUNT_NAME}"
    SECRET_NAME=$(kubectl -n ${NAMESPACE} get sa "${SERVICE_ACCOUNT_NAME}" -o json | jq -r .secrets[].name)
    echo "Secret name: ${SECRET_NAME}"
    printf "${GREEN}Done${NC}"
}
​
extract_ca_crt_from_secret() {
    echo -e -n "\\nExtracting ca.crt from secret..."
    kubectl -n ${NAMESPACE} get secret "${SECRET_NAME}" -o json | jq \
    -r '.data["ca.crt"]' | base64 -d > "${TARGET_FOLDER}/ca.crt"
    printf "${GREEN}Done${NC}"
}
​
get_user_token_from_secret() {
    echo -e -n "\\nGetting user token from secret..."
    USER_TOKEN=$(kubectl -n ${NAMESPACE} get secret "${SECRET_NAME}" -o json | jq -r '.data["token"]' | base64 -d)
    printf "${GREEN}Done${NC}"
}
​
set_kube_config_values() {
    context=$(kubectl config current-context)
    echo -e "\\nSetting current context to: $context"
​
    CLUSTER_NAME=$(kubectl config get-contexts "$context" | awk '{print $3}' | tail -n 1)
    echo "Cluster name: ${CLUSTER_NAME}"
​
    ENDPOINT=$(kubectl config view \
    -o jsonpath="{.clusters[?(@.name == \"${CLUSTER_NAME}\")].cluster.server}")
    echo "Endpoint: ${ENDPOINT}"
​
    # Set up the config
    echo -e "\\nPreparing ${KUBECFG_FILE_NAME}"
    echo -n "Setting a cluster entry in kubeconfig..."
    kubectl config set-cluster "${CLUSTER_NAME}" \
    --kubeconfig="${KUBECFG_FILE_NAME}" \
    --server="${ENDPOINT}" \
    --certificate-authority="${TARGET_FOLDER}/ca.crt" \
    --embed-certs=true
​
    echo -n "Setting token credentials entry in kubeconfig..."
    kubectl config set-credentials \
    "${SERVICE_ACCOUNT_NAME}-${NAMESPACE}-${CLUSTER_NAME}" \
    --kubeconfig="${KUBECFG_FILE_NAME}" \
    --token="${USER_TOKEN}"
​
    echo -n "Setting a context entry in kubeconfig..."
    kubectl config set-context \
    "${SERVICE_ACCOUNT_NAME}-${NAMESPACE}-${CLUSTER_NAME}" \
    --kubeconfig="${KUBECFG_FILE_NAME}" \
    --cluster="${CLUSTER_NAME}" \
    --user="${SERVICE_ACCOUNT_NAME}-${NAMESPACE}-${CLUSTER_NAME}" \
    --namespace="${NAMESPACE}"
​
    echo -n "Setting the current-context in the kubeconfig file..."
    kubectl config use-context "${SERVICE_ACCOUNT_NAME}-${NAMESPACE}-${CLUSTER_NAME}" \
    --kubeconfig="${KUBECFG_FILE_NAME}"
    printf "${GREEN}Done${NC}"
}
​
create_rbac() {
    echo -e -n "\\nCreating and applying RBAC..."
    cat << EOF > $TARGET_FOLDER/rbac.yml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-manager
  namespace: celgene-rt
rules:
- apiGroups: ["", "extensions", "apps","batch","autoscaling"]
  resources: ["*"]
  verbs: ["*"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: tiller-binding
  namespace: celgene-rt
subjects:
- kind: ServiceAccount
  name: kst-admin
  namespace: celgene-rt
roleRef:
  kind: Role
  name: tiller-manager
  apiGroup: rbac.authorization.k8s.io
EOF
    kubectl apply -f ${TARGET_FOLDER}/rbac.yml
    printf "${GREEN}Done${NC}"
}
​
check_required_software
create_target_folder
create_service_account
get_secret_name_from_service_account
extract_ca_crt_from_secret
get_user_token_from_secret
set_kube_config_values
create_rbac
​
echo -e "\\nAll done! Test with:"
echo "KUBECONFIG=${KUBECFG_FILE_NAME} kubectl get pods"
KUBECONFIG=${KUBECFG_FILE_NAME} kubectl -n ${NAMESPACE} get pods