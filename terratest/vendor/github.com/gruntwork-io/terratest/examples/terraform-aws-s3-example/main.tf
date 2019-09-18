# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A S3 BUCKET WITH VERSIONING ENABLED INCLUDING TAGS
# See test/terraform_aws_s3_example_test.go for how to write automated tests for this code.
# ---------------------------------------------------------------------------------------------------------------------

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    effect    = "Allow"
    principals {
      identifiers = ["${local.aws_account_id}"]
      type = "AWS"
    }
    actions   = ["*"]
    resources = ["${aws_s3_bucket.test_bucket.arn}/*"]
  }

  statement {
    effect    = "Deny"
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    actions   = ["*"]
    resources = ["${aws_s3_bucket.test_bucket.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false",
      ]
    }
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "${local.aws_account_id}-${var.tag_bucket_name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.tag_bucket_name}"
    Environment = "${var.tag_bucket_environment}"
  }
}

resource "aws_s3_bucket_policy" "bucket_access_policy" {
  count = "${var.with_policy ? 1 : 0}"
  bucket = "${aws_s3_bucket.test_bucket.id}"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"
}

# ---------------------------------------------------------------------------------------------------------------------
# LOCALS
# Used to represent any data that requires complex expressions/interpolations
# ---------------------------------------------------------------------------------------------------------------------

data "aws_caller_identity" "current" {}

locals {
  aws_account_id = "${data.aws_caller_identity.current.account_id}"
}
