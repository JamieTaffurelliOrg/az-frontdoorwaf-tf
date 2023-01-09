resource "azurerm_cdn_frontdoor_firewall_policy" "policy" {
  name                              = var.waf_policy_name
  resource_group_name               = var.resource_group_name
  sku_name                          = "Premium_AzureFrontDoor"
  enabled                           = var.enabled
  mode                              = var.mode
  redirect_url                      = var.redirect_url
  custom_block_response_status_code = var.custom_block_response_status_code
  custom_block_response_body        = var.custom_block_response_body

  dynamic "custom_rule" {
    for_each = { for k in var.custom_rules : k.name => k if k != null }

    content {
      name                           = custom_rule.value["name"]
      action                         = custom_rule.value["action"]
      enabled                        = custom_rule.value["enabled"]
      priority                       = custom_rule.value["priority"]
      type                           = custom_rule.value["type"]
      rate_limit_duration_in_minutes = custom_rule.value["rate_limit_duration_in_minutes"]
      rate_limit_threshold           = custom_rule.value["rate_limit_threshold"]

      dynamic "match_condition" {
        for_each = { for k in custom_rule.value["match_conditions"] : k.name => k if k != null }

        content {
          match_variable     = match_condition.value["match_variable"]
          operator           = match_condition.value["operator"]
          selector           = match_condition.value["selector"]
          negation_condition = match_condition.value["negation_condition"]
          match_values       = match_condition.value["match_values"]
          transforms         = match_condition.value["transforms"]
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = { for k in var.managed_rules : k.name => k if k != null }

    content {
      type    = managed_rule.value["type"]
      version = managed_rule.value["version"]
      action  = managed_rule.value["name"]

      dynamic "exclusion" {
        for_each = { for k in managed_rule.value["exclusions"] : k.name => k if k != null }

        content {
          match_variable = exclusion.value["match_variable"]
          operator       = exclusion.value["operator"]
          selector       = exclusion.value["selector"]
        }
      }

      dynamic "override" {
        for_each = { for k in managed_rule.value["overrides"] : k.name => k if k != null }

        content {
          rule_group_name = override.value["rule_group_name"]

          dynamic "exclusion" {
            for_each = { for k in override.value["exclusions"] : k.name => k if k != null }

            content {
              match_variable = exclusion.value["match_variable"]
              operator       = exclusion.value["operator"]
              selector       = exclusion.value["selector"]
            }
          }

          dynamic "rule" {
            for_each = { for k in override.value["rules"] : k.name => k if k != null }

            content {
              rule_id = rule.value["rule_id"]
              action  = rule.value["action"]
              enabled = rule.value["enabled"]

              dynamic "exclusion" {
                for_each = { for k in rule.value["exclusions"] : k.name => k if k != null }

                content {
                  match_variable = rule.value["match_variable"]
                  operator       = rule.value["operator"]
                  selector       = rule.value["selector"]
                }
              }

            }
          }
        }
      }
    }
  }

  tags = var.tags
}
