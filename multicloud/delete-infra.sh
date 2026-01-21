#!/bin/bash
set -e

cd terraform;

# Inicialize o Terraform
terraform init;

# Valide a configuração
terraform validate;

# Planeje as mudanças
terraform plan;

# Aplique a infraestrutura
terraform destroy;   