terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "${var.prefix}/terraform.tfstate"
    region = "${var.region}"
  }
}
