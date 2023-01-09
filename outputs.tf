output "waf_policy_id" {
  value       = azurerm_cdn_frontdoor_firewall_policy.policy.id
  description = "The resource ID of the front door waf policy"
}

output "waf_policy_endpoint_ids" {
  value       = azurerm_cdn_frontdoor_firewall_policy.policy.frontend_endpoint_ids
  sensitive   = true
  description = "The Front Door Profiles frontend endpoints associated with this Front Door Firewall Policy."
}
