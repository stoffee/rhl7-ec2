#variable "boinc_project_id" {
#  description = "Boinc Project id: boinccmd --lookup_account URL email password https://boinc.berkeley.edu/wiki/Boinccmd_tool"
#}
variable "ssh_key_name" {
  description = "You AWS SSH KeyName"
  default     = "cdunlap-sandbox-aws"
}

#variable "aws_access_key" {}
#variable "aws_secret_key" {}
#variable "aws_region" {}
variable "instance_type" {
  default     = "t3.medium"
  description = "Please be careful with cost!!!!"
}
