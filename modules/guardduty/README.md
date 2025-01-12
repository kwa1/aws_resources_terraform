# GuardDuty Module

This module sets up GuardDuty and invites member accounts to the detector.

## Inputs

- `guardduty_accounts` - A map of GuardDuty member account IDs and email addresses.

## Outputs

- `guardduty_detector_id` - The ID of the GuardDuty detector.

## Example Usage

```hcl
module "guardduty" {
  source              = "./modules/guardduty"
  guardduty_accounts  = {
    "123456789012" = "account1@example.com",
    "987654321098" = "account2@example.com"
  }
}
