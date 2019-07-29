#!/bin/bash

if [[ -f ${HOME}/.aws/login_aws.sh ]]; then
source ${HOME}/.aws/login_aws.sh
fi

let TIMESTAMP=$(date "+%Y%m%d%H%M%S")


bundle exec kitchen test


if command -v osascript; then
osascript -e 'tell app "System Events" to display alert "terraform-aws-eks" message "terraform-aws-eks kitchen test completed."'
fi
