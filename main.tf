
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

