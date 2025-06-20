# infra/iam.tf

# 1. Rola IAM dla EC2
resource "aws_iam_role" "ec2_role" {
  name               = "thesis-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# 2. Polityka inline dla tej roli
resource "aws_iam_role_policy" "ec2_policy" {
  name = "thesis-ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = data.aws_iam_policy_document.ec2_policy.json
}

# 3. Profile dla instancji EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "thesis-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# 4. Dokument polityki pozwalającej EC2 na PutMetricData i PutObject
data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      aws_s3_bucket.logs.arn,
      "${aws_s3_bucket.logs.arn}/*"
    ]
  }
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

# 5. Dokument assume role, żeby EC2 mogła tę rolę przyjąć
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
