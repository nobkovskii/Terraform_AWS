variable "public_key_path" {}
variable "private_key_path" {}

resource "aws_key_pair" "auth" {
  key_name   = "aws-key-pair"
  public_key = file(var.public_key_path)
}

variable "owner" {}
variable "project" {}