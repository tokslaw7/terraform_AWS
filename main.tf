
resource "aws_vpc" "terraform_demo_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform-demo-vpc"
  }
}

resource "aws_subnet" "terraform_demo_subnet" {
  vpc_id                  = aws_vpc.terraform_demo_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "terraform-demo-subnet"
  }
}

resource "aws_internet_gateway" "terraform_demo_igw" {
  vpc_id = aws_vpc.terraform_demo_vpc.id

  tags = {
    Name = "terraform-demo-igw"
  }
}

resource "aws_route_table" "terraform_demo_route_table" {
  vpc_id = aws_vpc.terraform_demo_vpc.id

  tags = {
    Name = "terraform-demo-route-table"
  }
}

resource "aws_route" "terraform_demo_route" {
  route_table_id         = aws_route_table.terraform_demo_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_demo_igw.id
}

resource "aws_route_table_association" "terraform_demo_route_table_association" {
  subnet_id      = aws_subnet.terraform_demo_subnet.id
  route_table_id = aws_route_table.terraform_demo_route_table.id
}

resource "aws_security_group" "terraform_demo_sg" {
  name        = "terraform-demo-sg"
  description = "Allow SSH and HTTP traffic-security group for Terraform demo"
  vpc_id      = aws_vpc.terraform_demo_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deploy_key" {
  key_name   = "terraform_demo_key"
  public_key = file("~/SSH/terraform_demo_key.pub")
}

resource "aws_instance" "terraform_demo_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deploy_key.key_name
  subnet_id              = aws_subnet.terraform_demo_subnet.id
  vpc_security_group_ids = [aws_security_group.terraform_demo_sg.id]
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "terraform-demo-instance"
  }

  provisioner "local-exec" {
    command = templatefile("mac-ssh-config.tpl", {
      hostname     = self.public_ip,
      username     = "ubuntu",
      identityfile = "~/SSH/terraform_demo_key"
    })
    interpreter = ["bash", "-c"]
  }
}