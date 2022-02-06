variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ami" {
    description = "AMIS by region"
    default ={
       us-east-1 = "ami-0ee02acd56a52998e"
    }
}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnet1_cidr" {}
variable "public_subnet2_cidr" {}
variable "public_subnet3_cidr" {}
variable "private_subnet_cidr" {}
variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "public_subnet3_name" {}
variable "private_subnet_name" {}
variable "Main_routing_table"  {}

