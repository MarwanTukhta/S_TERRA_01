data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "public" {
  subnet_id   = module.network.subnet_public_id
  private_ips = ["172.16.10.100"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  network_interface {
    network_interface_id = aws_network_interface.public.id
    device_index         = 0
  }

  vpc_security_group_ids = [module.network.sg_allow_ssh_id]

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > bastion.txt"
  }
}

resource "aws_network_interface" "private" {
  subnet_id   = module.network.subnet_private_id
  private_ips = ["172.16.11.100"]
}

resource "aws_instance" "application" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index         = 0
  }

  vpc_security_group_ids = [module.network.sg_allow_ssh2_id]
}