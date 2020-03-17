# output "petsuri_arn" {
#   value       = aws_iam_user.example[0].arn
#   description = "The ARN for user Petsuri"
# }

# output "all_arns" {
#   value       = aws_iam_user.example[*].arn
#   description = "The ARNs for all users"
# }

output "all_users" {
  value = aws_iam_user.example
}

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}
