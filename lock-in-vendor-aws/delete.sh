#!/bin/bash
set -e

STACK_NAME="python-app-devsecops-stack"

echo "Excluindo stack CloudFormation: $STACK_NAME ..."

aws cloudformation delete-stack --stack-name $STACK_NAME
