variable "bucket" {
  type        = string
  description = "The name of bucket."
}

variable "acl" {
  type        = string
  description = "Specify private or public acl."
}

variable "control_object_ownership" {
  type        = bool
  description = "Specify the object ownership control. TEST."
}

variable "object_ownership" {
  type        = string
  description = "The object ownership mode."
}

variable "versioning" {
  type = object({
    enabled = bool
  })
  description = "The bucket versioning."
}

