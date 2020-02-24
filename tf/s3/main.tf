#AWS provider region
provider "aws" {
  region     = "us-west-2"
}

#AWS s3 bucket creation to store the terraform state files
resource "aws_s3_bucket" "tf-remote-state" {
  bucket = "novaprospekt-bucket-test"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name            = "tf-state-lock"
  hash_key        = "LockID"
  read_capacity   = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB tf state locking"
  }
}

resource "aws_kms_key" "rds-key" {
    description = "key to encrypt rds password"
  tags = {
    Name = "my-rds-kms-key"
  }
}

resource "aws_kms_alias" "rds-kms-alias" {
  target_key_id = "${aws_kms_key.rds-key.id}"
  name = "alias/rds-kms-key"
} 

