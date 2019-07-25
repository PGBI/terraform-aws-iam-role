variable "project" {
  description = "Reference to a \"project\" module. See: https://registry.terraform.io/modules/PGBI/project/aws/"
}

variable "name" {
  type        = "string"
  description = "The name of the role."
}

variable "assume_role_policy" {
  type        = object({ Action = string, Effect = string, Principal = object({ Service = string }) })
  description = "The policy that grants an entity permission to assume the role."
}

variable "description" {
  type        = "string"
  description = "The description of the role."
}

variable "policies" {
  type        = map(object({ Action = list(string), Effect = string, Resource = string }))
  description = "Map of policies to attach to the role. The map keys will be used to name the policies."
}
