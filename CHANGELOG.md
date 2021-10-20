6.1.0

  * Stop letting types be forgiving

6.0.0

  * Tear out everything non-essential

5.0.2

  * Require the forwardable module where it is used

5.0.1

  * Remove the version requirement on duckface-interfaces

5.0.0

  * Rename persistence -> gateway to be consistent with the pattern used through our systems

4.0.1

  * CleanArchitecture::Serializers::JsonResponseFromResult: Pass the success value to the proc

4.0.0

  * Stop trying to be JSON API compliant - we never were and we never will be
  * Use a proc to generate success payload, so that it can be lazily generated

3.0.1-3.0.2

  * Add new failure code - unprocessable_entity

3.0.0

  * Add sorbet and support for Sorbet T::Struct

2.6.1

  * Update dependency on dry-validation

2.6.0

  * Bring `UseCases::AbstractUseCase` into line with dry-validation 1.0 & co.
    * Use cases now have a 'contract', params act as per normal
    * Predicates have been replaced with macros, they can still be shared
    * Context variables passed into the use case parameters are accessible within the use case as `context(:my_context)`
    * There is no need to redefine `initialize` in use cases, you can access context with `#context` and params via `#result_of_validating_params`

2.5.0

  * Remove restrictions on dry-rb gem

2.4.0

  * Introduce `UseCases::AbstractUseCase` to make it easier to create use cases with built in
    validation.
  * Add `UseCases::Form` to help map HTTP parameters to a use case's parameter object.

2.3.1

  * Fixed an issue with optional belongs_to relations in `AbstractActiveRecordEntityBuilder`

2.3.0

  * `AbstractActiveRecordEntityBuilder` now has a DSL for streamlining the use of builders for `has_many` and `belongs_to` relations.

2.2.0

  * Made `AbstractActiveRecordEntityBuilder` work with dry-struct >= 0.0.6.

2.1.0

  * Added `AbstractActiveRecordEntityBuilder` to help map ActiveRecord instances to `Dry::Struct` based entities.

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
