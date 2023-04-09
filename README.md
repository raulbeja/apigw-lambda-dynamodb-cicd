# Amazon API Gateway to AWS Lambda to Amazon DynamoDB

Deploy a sample application using Amazon API Gateway, AWS Lambda, and Amazon DynamoDB with terraform. When an HTTP POST request is made to the Amazon API Gateway endpoint, the AWS Lambda function is invoked and insert/retrieve an item into/from the Amazon DynamoDB table.

Send HTTP POST request to the Amazon API Gateway endpoint, the AWS Lambda function is invoked and insert or retrieve an item into or from the Amazon DynamoDB table.

Retrieve the HttpApiEndpoint value from the outputs of the terraform apply and try it making calls to /mypost endpoint using curl or Postman.

```
# Send an HTTP POST request an include a request body in the format below and the lambda function will create a new item in the dynamodb table

curl -X POST '<your http api endpoint>'/mypost \
> --header 'Content-Type: application/json' \
> -d '{"operation":"write","id":"1","name":"item one"}'

#sample output

{
  "message": "Operation successfully entered:"
}


curl -X POST '<your http api endpoint>'/mypost \
> --header 'Content-Type: application/json' \
> -d '{"operation":"read","id":"1"}'

#sample output

{
  "message": {"id":"1", "name":"item one"}
}
```