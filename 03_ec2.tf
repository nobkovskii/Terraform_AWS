# 最新のCentOS7のAMIを取得
data "aws_ami" "centos7_ami" {
  owners      = ["aws-marketplace"]
  most_recent = true
  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }
}

# 踏み台用サーバ
resource "aws_instance" "bastion" {
  ami                     = data.aws_ami.centos7_ami.id
  instance_type           = "t2.micro"
  disable_api_termination = false
  key_name                = aws_key_pair.auth.key_name
  vpc_security_group_ids  = [aws_security_group.bastion_security_group.id]
  subnet_id               = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.project}-Bastion"
    Owner = var.owner
    Project = var.project
  }
}

# セキュアサーバ
resource "aws_instance" "private" {
  ami                     = data.aws_ami.centos7_ami.id
  instance_type           = "t2.micro"
  disable_api_termination = false
  key_name                = aws_key_pair.auth.key_name
  vpc_security_group_ids  = [aws_security_group.private_security_group.id]
  subnet_id               = aws_subnet.private_subnet.id

  tags = {
    Name = "${var.project}-Private"
    Owner = var.owner
    Project = var.project
  }
}