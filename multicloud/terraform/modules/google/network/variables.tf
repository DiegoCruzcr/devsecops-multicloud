variable "ip_cidr_range" {
  type        = string
  description = "CIDR para a sub-rede primária"
  default     = "10.0.0.0/16"
  
}

variable "secondary_ip_range_services" {
  type        = string
  description = "CIDR para o intervalo secundário de serviços"
  default     = "192.168.0.0/24"
  
}

variable "secondary_ip_range_pods" {
  type        = string
  description = "CIDR para o intervalo secundário de pods"
  default     = "192.168.1.0/24"

}

variable "region" {
  type        = string
  description = "Região onde a rede e sub-rede serão criadas"  
}