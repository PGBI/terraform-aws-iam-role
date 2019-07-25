output "arn" {
  description = "ARN of the role."
  value       = aws_iam_role.main.arn
}

output "id" {
  description = "The name of the role."
  value       = aws_iam_role.main.id
}

output "name" {
  description = "The name of the role."
  value       = aws_iam_role.main.name
}
