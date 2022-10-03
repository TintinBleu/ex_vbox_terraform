# définition des variables

variable "nb" {
  description = "nombre de machines"
  type        = number
  default     = 1
}

variable "start" {
  description = "premiere machine de la série"
  type        = number
  default     = 1
}
