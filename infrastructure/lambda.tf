resource "aws_iam_policy" "osrs_dynamodb_policy" {
  name = "osrs-dynamodb-policy"

  policy = jsonencode({
    "Version" : "",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:*"
        ],
        "Resource" : aws_dynamodb_table.osrs_users
      }
    ]
  })

  tags = {
    project = "osrs"
  }
}

resource "aws_iam_role_policy_attachment" "osrs_lambda_dynamodb_policy_attachment" {
  policy_arn = aws_iam_policy.osrs_dynamodb_policy.arn
  role       = aws_iam_role.osrs_lambda_dynamodb_role.name
}

resource "aws_iam_role" "osrs_lambda_dynamodb_role" {
  name = "osrs-lambda-dynamodb-role"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Effect" : "Allow",
          "Sid" : ""
        }
      ]
    })

  tags = {
    project = "osrs"
  }
}

resource "aws_lambda_function" "osrs_highscore_to_db_lambda" {
  // required arguments
  function_name = "osrs-highscore-to-db"
  role          = aws_iam_role.osrs_lambda_dynamodb_role.arn

  // lambda code location and entry point
  s3_bucket = aws_s3_bucket.osrs_lambdas.id
  s3_key    = var.osrs_highscore_to_db_s3_key
  runtime   = "nodejs18.x"
  handler   = "index.js"

  // optional
  timeout = 3

  environment {
    variables = {
      USERS_TABLE_ARN = aws_dynamodb_table.osrs_users.arn
    }
  }

  tags = {
    project = "osrs"
  }
}
