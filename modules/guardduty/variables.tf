variable "guardduty_accounts" {
  description = "Map of GuardDuty member accounts and their email addresses."
  type        = map(string)
  default     = {}
}
