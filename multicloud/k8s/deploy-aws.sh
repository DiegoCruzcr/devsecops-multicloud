#!/bin/bash
set -e
# 782622073147.dkr.ecr.us-east-1.amazonaws.com/minha-app-repo:latest
IMAGE_TAG="v0.0.2"
REPOSITORY_NAME="minha-app-repo"
AWS_REGION="us-east-1"
ECR_URL="782622073147.dkr.ecr.$AWS_REGION.amazonaws.com"
CLUSTER_NAME="meu-cluster-eks"

echo "🚀 Iniciando deploy na AWS..."

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URL

echo "🐳 Fazendo build da imagem Docker..."
docker build -t $REPOSITORY_NAME:$IMAGE_TAG .

echo "🏷️  Fazendo tag da imagem..."
docker tag $REPOSITORY_NAME:$IMAGE_TAG $ECR_URL/$REPOSITORY_NAME:$IMAGE_TAG

echo "📤 Fazendo push da imagem..."
docker push $ECR_URL/$REPOSITORY_NAME:$IMAGE_TAG

echo "⚙️  Configurando kubectl para EKS..."
aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME

echo "Fazendo deploy no EKS..."

IMAGE="$ECR_URL/$REPOSITORY_NAME:$IMAGE_TAG"
sed -i 's|${IMAGE}|'"$IMAGE"'|g' deployment.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "⏳ Aguardando deployment ficar pronto..."
kubectl rollout status deployment/minha-app-repo
echo "📊 Informações do serviço:"
kubectl get svc -n default
echo "✅ Deploy na AWS concluído com sucesso!"
echo "💡 Para verificar o status: kubectl get pods"