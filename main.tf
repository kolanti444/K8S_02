provider "aws" {
    access_key = "${var.aws_access_key}" 
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_vpc" "terraform_vpc_demo" {
    cidr_block  = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        name = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "MYIGW" {
    vpc_id = "${aws_vpc.terraform_vpc_demo.id}"
    tags = {
        name = "${var.IGW_name}"
    }
}

resource "aws_subnet" "public-subnet1" {
    vpc_id            = "${aws_vpc.terraform_vpc_demo.id}"
    cidr_block        = "${var.public_subnet1_cidr}"
    availability_zone = "us-east-1a"
    tags = {
        name = "${var.public_subnet1_name}"
    }
}

resource "aws_subnet" "public-subnet2" {
    vpc_id            = "${aws_vpc.terraform_vpc_demo.id}"
    cidr_block        = "${var.public_subnet2_cidr}"
    availability_zone = "us-east-1b"
    tags = {
        name = "${var.public_subnet2_name}"
    }
}

resource "aws_subnet" "public-subnet3" {
    vpc_id            = "${aws_vpc.terraform_vpc_demo.id}"
    cidr_block        = "${var.public_subnet3_cidr}"
    availability_zone = "us-east-1c"
    tags = {
        name = "${var.public_subnet3_name}"
    }
}

resource "aws_route_table" "MYRT" {
    vpc_id     = "${aws_vpc.terraform_vpc_demo.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.MYIGW.id}"
   }
    tags = {
        name = "${var.Main_routing_table}"
    }
}

resource "aws_route_table_association" "MYRT" {
    subnet_id      = "${aws_subnet.public-subnet1.id}"
    route_table_id = "${aws_route_table.MYRT.id}"
}

resource "aws_security_group" "MYSG" {
    name         = "MYSG"
    description  = "allow all inbound traffic"
    vpc_id       = "${aws_vpc.terraform_vpc_demo.id}"

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
         from_port   = 0
        to_port      = 0
        protocol     = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
    
    }
}


