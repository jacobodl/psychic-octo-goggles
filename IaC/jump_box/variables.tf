variable "stage" {
  description = "Stage de AWS"
  type        = string
}

variable "ec2_ami_id" {
  description = "ID de la AMI"
  type        = string

}

variable "ec2_instance_type" {
  description = "Tipo de instancia"
  type        = string

}

variable "ec2_subnet_id" {
  description = "ID de la subnet"
  type        = string

}

variable "ec2_security_group_id" {
  description = "ID de SG"
  type        = string
}

variable "usuarios_jumpbox" {
  description = "Lista de nombres de usuarios para los cuales se crearán key pairs de EC2"
  type        = list(string)
}
