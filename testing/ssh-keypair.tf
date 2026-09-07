resource "aws_key_pair" "ssh-login" {
  key_name   = "NTL-key"
  public_key = file("${path.module}/id_rsa.pub")
}
