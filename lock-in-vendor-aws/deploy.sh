#!/bin/bash
set -e

STACK_NAME="python-app-devsecops-stack"
TEMPLATE_FILE="ecs-pipeline.yaml"
REGION="us-east-1"

echo "Validando template CloudFormation..."
aws cloudformation validate-template --template-body file://$TEMPLATE_FILE

echo "Criando/atualizando stack CloudFormation: $STACK_NAME ..."
aws cloudformation deploy \
  --template-file $TEMPLATE_FILE \
  --stack-name $STACK_NAME \
  --region $REGION \
  --capabilities CAPABILITY_NAMED_IAM

echo "Stack implantada/atualizada com sucesso."

# Se o pipeline já existir, você pode iniciar a execução com:
# PIPELINE_NAME="python-app-devsecops-pipeline"  # ajuste se seu pipeline tiver outro nome

# echo "Iniciando execução do pipeline: $PIPELINE_NAME ..."
# aws codepipeline start-pipeline-execution --name $PIPELINE_NAME

# echo "Deploy iniciado no CodePipeline."
