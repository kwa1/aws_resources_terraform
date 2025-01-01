output "cognito_users" {
  description = "List of created Cognito users with their usernames."
  value = { 
    for k, v in aws_cognito_user.user : k => {
      username = v.username
      user_id  = v.id
    }
  }
}

output "temporary_passwords" {
  description = "Generated temporary passwords for Cognito users."
  value = { 
    for k, v in random_password.tmp_pwd : k => v.result 
  }
}
