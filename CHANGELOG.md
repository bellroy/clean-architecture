1.0.1

  * Rename WithAuditTrail command

1.0.0

  * Remove strategy and command interfaces
  * Turn Authorization into a virtual class rather than an interface
  * Remove ActorGetsAuthorizedThenDoesWork in favour of having the Authorization virtual class
    return a result type (use .bind in the client)
  * Change WithAuditTrail to command with a result

0.2.0

  * Add Entities::FailureDetails and support for it in the various Serializers
  * Strategies::ActorGetsAuthorizedThenDoesWork returns Entities::FailureDetails when authorization
    fails

0.1.0

  * Add Adapters::AttributeHashBase

0.0.3 - 0.0.5

  * Fix require files
  * Update dependencies and fix load order problems

0.0.2

  * Add Serializers::SuccessPayload

0.0.1

  * Initial release
