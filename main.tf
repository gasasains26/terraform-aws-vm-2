provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key" {
  key_name   = "terraform-key-1"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0c02fb55956c7d316"  # Ubuntu AMI in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name

  tags = {
    Name = "UbuntuFromGitHub"
  }
}

terraform {
  backend "s3" {
    bucket = "tf-state-git-vm"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


