resource "aws_dynamodb_table" "osrs_users" {
  name           = "osrs-users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    project = "osrs"
  }
}
