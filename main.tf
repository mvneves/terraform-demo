provider "aws" {
  region = "us-east-1"
}

# Busca a AMI mais recente do Ubuntu 24.04 LTS publicada pela Canonical,
# em vez de fixar um ID que deixa de existir quando a AMI é descontinuada
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example-instance"
  }
}
