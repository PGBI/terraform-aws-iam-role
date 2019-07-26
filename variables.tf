variable "project" {
  description = "Reference to a \"project\" module. See: https://registry.terraform.io/modules/PGBI/project/aws/"
}

variable "name" {
  type        = "string"
  description = "The name of the role."
}

variable "trusted_iam_arns" {
  description = "List of ARNs of IAM entities allowed to assume that Role."
  default     = []
  type        = list(string)
}

variable "trusted_services" {
  description = "List of AWS Services that can assume that Role."
  default     = []
  type        = list(string)
}

variable "description" {
  type        = "string"
  description = "The description of the role."
}

variable "policies" {
  type        = map(object({ Action = list(string), Effect = string, Resource = string }))
  description = "Map of policies to attach to the role. The map keys will be used to name the policies."
  default     = {}
}
