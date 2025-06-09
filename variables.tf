variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "multi-cloud-k8s-461703"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "VPC Network name"
  type        = string
  default     = "multi-cloud-vpc"
}

variable "subnet_cidr" {
  description = "CIDR range for subnet"
  type        = string
  default     = "10.0.0.0/16"
}