resource "aws_iam_role" "iam_role_for_lambda" {
  name = var.role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = var.role_policy_name
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement= [{
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.lambda_s3_bucket}",
          "arn:aws:s3:::${var.lambda_s3_bucket}/*"
        ]
      },
      {
        Action = [
          "dynamodb:List*",
          "dynamodb:DescribeReservedCapacity*",
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeTimeToLive"
        ],
        Resource = "*",
        Effect = "Allow"
      },
      {
        Action = [
          "dynamodb:BatchGet*",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTable",
          "dynamodb:Get*",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWrite*",
          "dynamodb:CreateTable",
          "dynamodb:Delete*",
          "dynamodb:Update*",
          "dynamodb:PutItem"
        ],
        Resource = [
          "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
        ],
        Effect = "Allow"
      },
      {
        Action = [
          "lambda:UpdateFunctionCode",
          "lambda:PublishVersion"
        ],
        Resource = "*",
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam-policy-attach" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

resource "aws_lambda_function" "myLambda" {

  function_name = var.lambda_function_name
  s3_bucket     = var.lambda_s3_bucket
  s3_key        = var.lambda_s3_key
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = "${var.lambda_function_name}.handler"
  runtime       = "nodejs12.x"

  environment {
    variables = {
      table_name = "${var.dynamodb_table_name}"
    }
  }
}