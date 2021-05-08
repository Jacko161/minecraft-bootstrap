variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "keypair_name" {
  type    = string
  default = "minecraft"
}

variable "pem_location" {
  type    = string
  default = "~/.ssh/server.pem"
}

variable "instance_size" {
  type    = string
  default = "t4g.medium"
}

variable "ami" {
  type    = string
  default = "ami-0ce84f166e6e3ad45"
}