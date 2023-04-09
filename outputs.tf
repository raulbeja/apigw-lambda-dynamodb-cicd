output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}

output "resource" {
  value = var.path_parameter
}

output "lambda_function"{
  value = var.lambda_function_name
}

output "bucket_name" {
  value = var.lambda_s3_bucket
}