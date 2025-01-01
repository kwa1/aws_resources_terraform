resource "random_password" "tmp_pwd" {
  for_each = var.users

  length  = lookup(each.value, "password_length", 10)
  special = lookup(each.value, "special", false)
  number  = lookup(each.value, "number", true)
  upper   = lookup(each.value, "upper", true)
}

resource "aws_cognito_user" "user" {
  for_each = var.users

  username           = each.value.username
  user_pool_id       = aws_cognito_user_pool.this[each.value.user_pool_name].id
  temporary_password = random_password.tmp_pwd[each.key].result

  attributes = {
    email          = each.value.email
    email_verified = lookup(each.value, "email_verified", true)
  }

  lifecycle {
    prevent_destroy = true
  }
}
