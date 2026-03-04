output "demo_ip" {
  value = aws_instance.terraform_demo_instance.public_ip
}