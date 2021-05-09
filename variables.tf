
variable "region" {
  type = string
  description = "The region to create the instance in, see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html"
  default = "ap-southeast-2"
}

variable "keypair_name" {
  type = string
  description = "The keypair to use for creating the server and allowing SSH"
  default = "minecraft"
}

variable "pem_location" {
    type = string
    description = "The location of the PEM file to use for SSH"
    default = "~/.ssh/server.pem"
}

variable "instance_size" {
    type = string
    description = "The instance size to create"
    default = "t4g.medium"
}

variable "ami" {
  type = string
  description = "The ami to use for creating the server."
  default = "ami-0ce84f166e6e3ad45"
}