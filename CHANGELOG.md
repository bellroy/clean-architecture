2.0.0

  * Support collections for use case targets and success payloads

1.2.0

  * Support arrays being passed as failure value to UseCaseResult matcher

1.1.1

  * Remove parameters from use case interface

1.1.0

  * Remove use case history entry code

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
