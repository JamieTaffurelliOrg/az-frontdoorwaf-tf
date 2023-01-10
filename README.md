# az-frontdoorwaf-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.20 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cdn_frontdoor_firewall_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_block_response_body"></a> [custom\_block\_response\_body](#input\_custom\_block\_response\_body) | If a custom\_rule block's action type is block, this is the response body. The body must be specified in base64 encoding. | `string` | `null` | no |
| <a name="input_custom_block_response_status_code"></a> [custom\_block\_response\_status\_code](#input\_custom\_block\_response\_status\_code) | If a custom\_rule block's action type is block, this is the response status code. Possible values are 200, 403, 405, 406, or 429 | `number` | `403` | no |
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | Front Door WAF Policy custom rules | <pre>list(object(<br>    {<br>      name                           = string<br>      action                         = string<br>      enabled                        = optional(bool, true)<br>      priority                       = number<br>      type                           = string<br>      rate_limit_duration_in_minutes = optional(number)<br>      rate_limit_threshold           = optional(number)<br>      match_conditions = list(object({<br>        match_variable     = string<br>        operator           = string<br>        selector           = optional(string)<br>        negation_condition = optional(bool, false)<br>        match_values       = list(string)<br>        transforms         = optional(list(string))<br>      }))<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable the WAF policy | `bool` | `true` | no |
| <a name="input_managed_rules"></a> [managed\_rules](#input\_managed\_rules) | Front Door WAF Policy managed rules | <pre>list(object(<br>    {<br>      name    = string<br>      type    = string<br>      version = string<br>      action  = string<br>      exclusions = list(object(<br>        {<br>          match_variable = string<br>          operator       = string<br>          selector       = string<br>      }))<br>      overrides = list(object(<br>        {<br>          name            = string<br>          rule_group_name = string<br>          exclusions = list(object({<br>            match_variable = string<br>            operator       = string<br>            selector       = string<br>          }))<br>          rules = list(object({<br>            rule_id = string<br>            action  = string<br>            enabled = optional(bool, true)<br>            exclusions = list(object(<br>              {<br>                match_variable = string<br>                operator       = string<br>                selector       = string<br>            }))<br>          }))<br>        }<br>      ))<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | WAF mode, Detection or Prevention | `string` | `"Prevention"` | no |
| <a name="input_redirect_url"></a> [redirect\_url](#input\_redirect\_url) | If action type is redirect, this field represents redirect URL for the client | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group name to deploy to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_waf_policy_name"></a> [waf\_policy\_name](#input\_waf\_policy\_name) | Name of the Front Door WAF Policy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_waf_policy_endpoint_ids"></a> [waf\_policy\_endpoint\_ids](#output\_waf\_policy\_endpoint\_ids) | The Front Door Profiles frontend endpoints associated with this Front Door Firewall Policy. |
| <a name="output_waf_policy_id"></a> [waf\_policy\_id](#output\_waf\_policy\_id) | The resource ID of the front door waf policy |
<!-- END_TF_DOCS -->
