resource "tls_private_key" "clave_privada_jumpbox" {
  for_each  = toset(var.usuarios_jumpbox)
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair_jumpbox" {
  for_each   = toset(var.usuarios_jumpbox)
  key_name   = each.value
  public_key = tls_private_key.clave_privada_jumpbox[each.value].public_key_openssh
}


resource "aws_s3_bucket" "key_pairs_bucket" {
  bucket = "simposio-${var.stage}-key-pairs"
}

resource "aws_s3_object" "users_key_pair" {
  for_each   = toset(var.usuarios_jumpbox)
  bucket     = aws_s3_bucket.key_pairs_bucket.id
  key        = "simposio-${each.value}-${var.stage}-pk.pem"
  content    = tls_private_key.clave_privada_jumpbox[each.value].private_key_pem
  acl        = "private"
  depends_on = [aws_s3_bucket.key_pairs_bucket]
}

resource "aws_instance" "jumpbox" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.key_pair_jumpbox["admin"].key_name
  subnet_id                   = var.ec2_subnet_id
  vpc_security_group_ids      = [var.ec2_security_group_id]
  associate_public_ip_address = true

}