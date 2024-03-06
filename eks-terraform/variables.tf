variable "access_key" {
    description = "value of the access key"
}

variable "secret_key" {
    description = "value of the secret key"
}

variable "region" {
    description = "value of the region"
}

variable "security_groups" {
    description = "value of the security groups"
}

variable "subnet_id_1" {
    description = "value of the subnet id 1"
}

variable "subnet_id_2" {
    description = "value of the subnet id 2"
}

variable "subnet_id_3" {
    description = "value of the subnet id 3"
}

variable "vpc_id" {
    description = "value of the vpc id"
}

variable "principal_arn" {
    description = "value of the principal arn"
}

variable "policy_arn" {
    description = "value of the policy arn"
    default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
}

variable "cluster_name" {
    description = "value of the cluster name"
    default = "test-cluster"
}

variable "Environment" {
    description = "value of the environment"
    default = "dev"
}

variable "Terraform" {
    description = "value of the terraform"
    default = "true"
}

variable project {
    description = "value of the project"
    default = "url_shortener"
}

variable "owner" {
    description = "value of the owner"
    default = "terrorblade"
}