data "archive_file" "api_code_archive" {
  type        = "zip"
  source_file = "${path.root}/${var.lambda_function_name}.js"
  output_path = "${path.root}/${var.lambda_function_name}.zip"
}

resource "aws_s3_object" "code_archive" {
  bucket = "${var.lambda_s3_bucket}"
  key    = "${var.lambda_s3_key}"
  source = data.archive_file.api_code_archive.output_path
  etag   = filemd5(data.archive_file.api_code_archive.output_path)

  lifecycle {
    ignore_changes = [etag]
  }
}
