variable "input" {
  type = object({
    version                  = string
    bucket                   = string
    acl                      = string
    control_object_ownership = bool
    object_ownership         = string
    versioning = object({
      enabled = bool
    })
  })

}
