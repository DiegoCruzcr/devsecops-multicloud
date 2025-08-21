variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "image_tag_mutability" {
  description = "Define se as tags da imagem são mutáveis ou imutáveis"
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "Tags para o repositório"
  type        = map(string)
  default     = {}
}
