resource "azurerm_application_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    capacity = 1
  }
  gateway_ip_configuration {
    name = "gw-ip-config"
    subnet_id = var.subnet_id
  }
  frontend_port {
    name = "http"
    port = 80
  }
  frontend_ip_configuration {
    name = "frontend"
    public_ip_address_id = var.public_ip_id
  }
  backend_address_pool { name = "backend-pool" }
  backend_http_settings {
    name = "http-settings"
    cookie_based_affinity = "Disabled"
    port = 80
    protocol = "Http"
    request_timeout = 30
  }
  http_listener {
    name = "listener"
    frontend_ip_configuration_name = "frontend"
    frontend_port_name = "http"
    protocol = "Http"
  }
  request_routing_rule {
    name = "rule"
    rule_type = "Basic"
    http_listener_name = "listener"
    backend_address_pool_name = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority = 100
  }
  tags = var.tags
}
