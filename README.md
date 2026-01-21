# Pipeline DevSecOps Multicloud

![DevSecOps Architecture](https://github.com/user-attachments/assets/6a9c1b51-760b-498a-89ce-ddf596fad6a7)

## Resumo Executivo

A adoção de ambientes multi-cloud tem crescido significativamente devido à busca por redução de custos, disponibilidade e mitigação de riscos de dependência de fornecedores. Nesse contexto, arquiteturas agnósticas desempenham papel estratégico ao permitir a portabilidade de workloads entre diferentes provedores sem necessidade de reconfigurações extensivas.

O presente trabalho propõe e valida uma arquitetura agnóstica de DevSecOps em ambientes multi-cloud, utilizando um simples servidor web, comparando-a com uma arquitetura lock-in baseada exclusivamente em serviços da AWS. A implementação demonstra que a adoção de uma abordagem agnóstica promove maior resiliência, segurança e escalabilidade em ambientes multi-cloud, reduzindo riscos estratégicos e operacionais para as organizações.

## Arquitetura Geral

### Visão Estratégica

O projeto implementa duas abordagens distintas para demonstrar os trade-offs entre arquiteturas vendor lock-in e cloud-agnostic:

1. **Arquitetura Lock-in (AWS)**: Utiliza serviços específicos da AWS (ECS, CloudFormation, CodePipeline)
2. **Arquitetura Cloud-Agnostic**: Baseada em Kubernetes, Terraform e ferramentas open-source

## Componentes do Sistema

### 1. Aplicação Base

**Servidor Web Python (Flask)**
```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello World!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

### 2. Containerização

**Dockerfile Otimizado**
- Base image: Python alpine para redução de superfície de ataque
- Multi-stage build para otimização de tamanho
- Non-root user para segurança

### 3. Infrastructure as Code (IaC)

**Terraform Modular**
- Módulos reutilizáveis para AWS, Azure e Google Cloud
- Configuração centralizada via variables.tf
- State management com backend remoto

## Implementações

### Arquitetura Lock-in (AWS)

**Diretório**: `lock-in-vendor-aws/`

**Componentes**:
- **ECS Fargate**: Orquestração de containers serverless
- **Application Load Balancer**: Distribuição de tráfego
- **CloudFormation**: Provisionamento de infraestrutura
- **CodePipeline**: Pipeline de CI/CD nativo da AWS
- **ECR**: Registry de containers privado

**Características**:
- Integração nativa com ecossistema AWS
- Menor complexidade inicial de configuração
- Forte acoplamento com serviços proprietários
- Limitações de portabilidade

### Arquitetura Cloud-Agnostic

**Diretório**: `multicloud/`

**Componentes**:
- **Kubernetes (EKS/GKE/AKS)**: Orquestração padronizada
- **Terraform**: Provisionamento multi-cloud
- **GitHub Actions**: Pipeline de CI/CD independente
- **Container Registries**: ECR, GCR, ACR conforme provider

## Configuração e Deploy

### Pré-requisitos

```bash
# Ferramentas obrigatórias
- AWS CLI v2.x
- Terraform v1.12+
- Docker v20.x+
- kubectl v1.28+
- Git v2.x+

# Permissões necessárias
- AWS: AdministratorAccess (para setup inicial)
- GitHub: Repository admin (para configurar Actions)
```

### Setup da Arquitetura Cloud-Agnostic

#### 1. Configuração do Terraform

```bash
# Navegue para o diretório terraform
cd multicloud/terraform

# Inicialize o Terraform
terraform init

# Valide a configuração
terraform validate

# Planeje as mudanças
terraform plan

# Aplique a infraestrutura
terraform apply -auto-approve
```

#### 2. Configuração do Kubernetes

```bash
# Configure o kubeconfig para AWS EKS
aws eks update-kubeconfig --region us-east-1 --name meu-cluster-eks

# Verifique a conectividade
kubectl cluster-info

# Deploy da aplicação
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

#### 3. Pipeline de CI/CD

O pipeline GitHub Actions (`.github/workflows/deploy.yml`) executa:

1. **Build**: Construção da imagem Docker
2. **Security**: Scan de vulnerabilidades com Trivy
3. **Test**: Execução de testes automatizados
4. **Deploy**: Deployment no cluster Kubernetes
5. **Verify**: Verificação de health da aplicação

### Setup da Arquitetura Lock-in

```bash
# Navigate to lock-in directory
cd lock-in-vendor-aws

# Deploy infrastructure via CloudFormation
aws cloudformation create-stack \
  --stack-name python-app-stack \
  --template-body file://ecs-pipeline.yaml \
  --capabilities CAPABILITY_IAM

# Build and push image
./deploy.sh
```

## Operações

### Comandos de Operação Básicos

#### Build e Deploy de Imagem

```bash
# Login no ECR
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  782622073147.dkr.ecr.us-east-1.amazonaws.com

# Build da aplicação
docker build -t minha-app-repo/minha-app:v0.0.1 .

# Tag da imagem
docker tag minha-app-repo/minha-app:v0.0.1 \
  782622073147.dkr.ecr.us-east-1.amazonaws.com/minha-app-repo:v0.0.1

# Push para registry
docker push 782622073147.dkr.ecr.us-east-1.amazonaws.com/minha-app-repo:v0.0.1
```

#### Operações Kubernetes

```bash
# Deploy/Update de aplicação
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Atualização de imagem (Rolling Update)
kubectl set image deployment/minha-app-repo \
  minha-app-repo=782622073147.dkr.ecr.us-east-1.amazonaws.com/minha-app-repo:latest

# Verificação de status do rollout
kubectl rollout status deployment/minha-app-repo

# Restart de deployment
kubectl rollout restart deployment minha-app-repo

# Limpeza de ReplicaSets antigos
kubectl delete rs --all
```

#### Troubleshooting

```bash
# Verificar status dos pods
kubectl get pods -l app=minha-app-repo

# Logs da aplicação
kubectl logs -f deployment/minha-app-repo

# Describe de recursos para debug
kubectl describe deployment minha-app-repo
kubectl describe service minha-app-repo

# Port forwarding para teste local
kubectl port-forward service/minha-app-repo 8080:80
```

## Segurança

### DevSecOps Pipeline

1. **Análise Estática de Código**: SonarQube integration
2. **Vulnerability Scanning**: Trivy para imagens Docker
3. **Secrets Management**: AWS Secrets Manager / K8s Secrets
4. **Network Security**: Security Groups / Network Policies
5. **Access Control**: RBAC no Kubernetes

## Resultados e Métricas

### Comparativo de Performance

Os resultados preliminares da implementação indicaram:

**Arquitetura Lock-in (AWS)**:
- Pipeline médio: 4 minutos
- Reutilização de artefatos: 11% (durante migração para GCP)
- Custo estimado: US$ 46,65/mês
- Forte acoplamento com serviços AWS

**Arquitetura Cloud-Agnostic**:
- Pipeline médio: 6 minutos
- Reutilização de artefatos: 85%
- Custo estimado: 
- Flexibilidade para migração entre clouds

### Limitações e Trabalhos Futuros

- Análise de custos em cenários de alta escala
- Implementação completa em Azure e Google Cloud
- Benchmarks de performance sob carga
- Integração com ferramentas de FinOps

---

**Referências**:
- [AWS ECS Best Practices](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/intro.html)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform Multi-Cloud](https://www.terraform.io/docs/providers/)
- [CNCF Landscape](https://landscape.cncf.io/)

**Autor**: Diego Cruz  
**Última Atualização**: Setembro 2025  
**Versão**: 1.0