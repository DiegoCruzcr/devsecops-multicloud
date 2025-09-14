#!/bin/bash

# Script de deploy para Google Cloud Platform (GKE)
# Certifique-se de ter o gcloud CLI instalado e configurado

set -e

# Configurações (ajuste conforme necessário)
# us-central1-docker.pkg.dev/devsecops-multicloud/minha-app-repo/minha-app-repo:v0.0.1
PROJECT_ID="devsecops-multicloud"  # Substitua pelo seu Project ID
REGION="us-central1"
CLUSTER_NAME="multicloud-autopilot-cluster"
REPOSITORY_NAME="minha-app-repo"
IMAGE_TAG="v0.0.1"

echo "🚀 Iniciando deploy no Google Cloud Platform..."

# 1. Configurar autenticação
echo "📋 Configurando autenticação..."
gcloud config set project $PROJECT_ID

# 2. Fazer build da imagem Docker
echo "🐳 Fazendo build da imagem Docker..."
docker build -t $REPOSITORY_NAME:$IMAGE_TAG .

# 3. Configurar Docker para Artifact Registry
echo "🔐 Configurando Docker para Artifact Registry..."
gcloud auth configure-docker $REGION-docker.pkg.dev

# 4. Fazer tag da imagem
echo "🏷️  Fazendo tag da imagem..."
docker tag $REPOSITORY_NAME:$IMAGE_TAG $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$REPOSITORY_NAME:$IMAGE_TAG

# 5. Fazer push da imagem
echo "📤 Fazendo push da imagem..."
docker push $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$REPOSITORY_NAME:$IMAGE_TAG

# 6. Configurar kubectl para GKE
echo "⚙️  Configurando kubectl para GKE..."
gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID

# 7. Atualizar deployment com a imagem correta
echo "📝 Atualizando deployment com IMAGE..."
IMAGE="$REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/$REPOSITORY_NAME:$IMAGE_TAG"
sed -i 's|${IMAGE}|'"$IMAGE"'|g' deployment.yaml

# 8. Aplicar recursos Kubernetes
echo "🚢 Aplicando recursos Kubernetes..."

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# 9. Aguardar deployment
echo "⏳ Aguardando deployment ficar pronto..."
kubectl rollout status deployment/minha-app-repo

# 10. Obter informações do serviço
echo "📊 Informações do serviço:"
kubectl get services minha-app-repo-service

echo "✅ Deploy no GKE concluído com sucesso!"
echo "💡 Para verificar o status: kubectl get pods"
echo "🌐 Para obter o IP externo: kubectl get services minha-app-repo-service"
