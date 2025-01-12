resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_guardduty_member" "member" {
  for_each   = var.guardduty_accounts != {} ? var.guardduty_accounts : {}
  account_id = each.key
  email      = each.value
  invite     = true
}
