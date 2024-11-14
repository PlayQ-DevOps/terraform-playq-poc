locals {
  input_file         = "./input.yaml"
  input_file_content = fileexists(local.input_file) ? file(local.input_file) : "NoInputFileFound: true"
  input              = yamldecode(local.input_file_content)
}

module "private_bucket" {
  source = "./modules/s3/wrapper"
  input  = local.input
}
