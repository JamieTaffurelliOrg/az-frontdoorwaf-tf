variable "resource_group_name" {
  type        = string
  description = "Resource Group name to deploy to"
}

variable "waf_policy_name" {
  type        = string
  description = "Name of the Front Door WAF Policy"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable the WAF policy"
}

variable "mode" {
  type        = string
  default     = "Prevention"
  description = "WAF mode, Detection or Prevention"
}

variable "redirect_url" {
  type        = string
  default     = null
  description = "If action type is redirect, this field represents redirect URL for the client"
}

variable "custom_block_response_status_code" {
  type        = number
  default     = 403
  description = "If a custom_rule block's action type is block, this is the response status code. Possible values are 200, 403, 405, 406, or 429"
}

variable "custom_block_response_body" {
  type        = string
  default     = null
  description = "If a custom_rule block's action type is block, this is the response body. The body must be specified in base64 encoding."
}

variable "custom_rules" {
  type = list(object(
    {
      name                           = string
      action                         = string
      enabled                        = optional(bool, true)
      priority                       = number
      type                           = string
      rate_limit_duration_in_minutes = optional(number)
      rate_limit_threshold           = optional(number)
      match_conditions = list(object({
        match_variable     = string
        operator           = string
        selector           = optional(string)
        negation_condition = optional(bool, false)
        match_values       = list(string)
        transforms         = optional(list(string))
      }))
    }
  ))
  default     = []
  description = "Front Door WAF Policy custom rules"
}

variable "managed_rules" {
  type = list(object(
    {
      name    = string
      type    = string
      version = string
      action  = string
      exclusions = list(object(
        {
          match_variable = string
          operator       = string
          selector       = string
      }))
      overrides = list(object(
        {
          name            = string
          rule_group_name = string
          exclusions = list(object({
            match_variable = string
            operator       = string
            selector       = string
          }))
          rules = list(object({
            rule_id = string
            action  = string
            enabled = optional(bool, true)
            exclusions = list(object(
              {
                match_variable = string
                operator       = string
                selector       = string
            }))
          }))
        }
      ))
    }
  ))
  default     = []
  description = "Front Door WAF Policy managed rules"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
