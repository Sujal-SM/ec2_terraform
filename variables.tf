variable "ami_id" {
  default = "ami-02d26659fd82cf299"
  type    = string
}

variable "env" {
  default = "prd"
  type    = string
}

variable "storage_size" {
  default = 10
  type    = number
  
}