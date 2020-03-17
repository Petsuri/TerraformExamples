variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["Petsuri", "Mei", "Arnold"]
}

variable "give_petsuri_cloudwatch_full_access" {
  description = "If true, Petsuri gets full access to CloudWatch"
  type        = bool
}
