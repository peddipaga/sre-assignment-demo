resource "tls_private_key" "argocd" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "argocd" {
  private_key_pem = tls_private_key.argocd.private_key_pem

  subject {
    common_name  = "argocd.hippocraticdemo.com"
    organization = "demo"
  }

  validity_period_hours = 8760  # 1 year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  dns_names = ["argocd.hippocraticdemo.com"]
}
