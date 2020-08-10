//variable "aws_image_id" {
//  description = "add aws_image_id"
//  type        = string
 // default     = file("/home/vagrant/site/terraform/ami_in.sh")
  //  default     = "ami-00f6a0c18edb19300"
//}

variable "aws_image_id" {
  description = "add aws_image_id"
  //  type        = string
  //  default     = "ami-076a2a9ae90dcf153"
  //  default     = "ami-00f6a0c18edb19300"
}

variable "aws_sg" {
  description = "add sg "
  type        = string
}

variable "aws_public_subnet" {
  description = "add aws_image_id"
  type        = string
}
variable "rds_depends_on" {
  type = any
}
