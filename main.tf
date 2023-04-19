terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {

}

resource "aws_lb" "example" {
  name               = "example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.example.id]
  
}

resource "aws_security_group" "example" {
  name_prefix = "example"
}
/*

resource "aws_subnet" "example" {
  cidr_block = "10.0.0.0/24" 
}
*/
resource "aws_lb_target_group" "example" {
  name_prefix      = "demo"
  port             = 80
  protocol         = "HTTP"
  target_type      = "instance"
  vpc_id           = aws_vpc.example.id
  health_check {
    path = "/health"
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

