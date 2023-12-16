terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 3.74.2"
        }
      }

      required_version = ">= 0.14.9"
    }

    provider "aws" {
      profile = "default"
      region  = "us-east-1"
      access_key="ASIASM4EGTWYAZWMFDPT"
      secret_key="Fwa/SYEHdbXUbRjjl8a5X6Ckk4ayr3UTpBdcinxv"
      token="FwoGZXIvYXdzEBkaDAyv5wUkLxzvtGPThyLPAdJ71ta8UWe4ziJaR+2UyhG/9kkmkeDjyU/08e8eYs9mv+3rlXCyjkA1qPA9xUarY5aM7RdSGL7uyu3s9xoRVJNK/GYMW2XtJuJj33MuhIkToc3kmA4PA35tVFWwUpphYownWn5OnfGFmeIRBAlHkaSt7a1KjFMCXH14szSvo+cWnMMLzoSKXGgCxVtT+ltCYKAAtTHGf3lgtlc7lI2PF1qBXx3w1Yirro/oaZjo/cR70EE5tr+t8FZP4euLVT6KNzerx7qZ7ZWboAeSoKlVZSinwfOrBjItS81QCnVHPxCwJ4xcPrkfkGnAnyurB5Ja53KSyPWDkLOq/acnw521zJbC7zac"

    }

    resource "aws_instance" "app_server" {
      ami           = "ami-0fc5d935ebf8bc3bc"
      instance_type = "t2.micro"
      key_name = "chave-ssh"

      vpc_security_group_ids = [
        "acesso_geral"
      ] 
    }

    resource "aws_key_pair" "chaveSSH" {
        key_name = "chave-ssh"
        public_key = file("../chave-ssh.pub")
    }

    resource "aws_security_group" "acesso_geral" {
      name = "acesso_geral"
      description = "grupo do Dev"
      ingress{
          cidr_blocks = [ "0.0.0.0/0" ]
          ipv6_cidr_blocks = [ "::/0" ]
          from_port = 0
          to_port = 0
          protocol = "-1"
      }
      egress{
          cidr_blocks = [ "0.0.0.0/0" ]
          ipv6_cidr_blocks = [ "::/0" ]
          from_port = 0
          to_port = 0
          protocol = "-1"
      }
      tags = {
        Name = "acesso_geral"
      }
    }

    output "IP_publico" {
      value = aws_instance.app_server.public_ip
    }