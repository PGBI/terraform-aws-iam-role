terraform {
  required_version = ">= 0.12.6"
}

/**
 * The IAM Role.
 */
resource "aws_iam_role" "main" {
  description = var.description
  name        = "${var.project.name_prefix}-${var.name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = var.trusted_services
        AWS     = var.trusted_iam_arns
      }
    }]
  })
  tags = var.project.tags
}

/**
 * Attaching IAM policies to the Role.
 */
resource "aws_iam_role_policy" "main" {
  for_each = var.policies

  name = each.key
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [each.value]
  })
  role = aws_iam_role.main.id
}
