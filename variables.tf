variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"  
}

variable "api_name" {
  description = "API Gateway Name"
  type        = string
  default     = "myAPI"  
}

variable "path_parameter" {
  description = "API Gateway Resource as Path Parameter"
  type        = string
  default     = "mypost"  
}

variable "api_deploy_stage" {
  description = "Stage name to deploy API Gateway"
  type        = string
  default     = "mysandbox"  
}

variable "role_name" {
  description = "Role Name for DynamoDb"
  type = string
  default = "mydynamodbrole"
}

variable "role_policy_name" {
  description = "Policy Name for DynamoDb Role"
  type = string
  default = "lambda_policy"
}

variable "dynamodb_table_name" {
  description = "DynamoDb Table Name"
  type = string
  default = "mydb"
}

variable "lambda_function_name" {
  description = "DynamoDb Table Name"
  type = string
  default = "mylambdafunction"
}

variable "lambda_s3_bucket" {
  description = "DynamoDb Table Name"
  type = string
  default = "rbgsandbox"
}

variable "lambda_s3_key" {
  description = "DynamoDb Table Name"
  type = string
  default = "mylambdafunction.zip"
}