# Clean Architecture

This gem provides helper interfaces and classes to assist in the construction of application with
Clean Architecture, as described in [Robert Martin's seminal book](https://www.amazon.com/gp/product/0134494164).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clean-architecture'
```

And then execute:

    $ bundle install
    $ bundle binstubs clean-architecture

## Usage

The intention of this gem is to help you build applications that are built from the use case down,
and decisions about I/O can be deferred until the last possible moment. It relies heavily on the
[duckface-interfaces](https://github.com/samuelgiles/duckface) gem to enforce interface
implementation.

### Use cases as an organisational principle

Uncle Bob suggests that your source code organisation should allow developers to easily find a
listing of all use cases your application provides. Here's an example of how this might look in a
Rails application.

```
- lib
  - my_banking_application
    - use_cases
      - retail_customer_opens_bank_account.rb
      - retail_customer_makes_a_deposit.rb
      - ...
```

### Clean architecture principles

* The code that manages your inputs (e.g. a Rails controller) instantiates a persistence layer
  object
  - Suggest: a class that implements both the `Persistence` interface and your own persistence
    interface

```
  persistence = ActiveRecordPersistence.new
```

* The code that manages your inputs (e.g. a Rails controller) instantiates a use case actor
  object
  - Suggest: a class that implements the `UseCaseActor` interface

```
  use_case_actor = MyUseCaseActorAdapter.new(devise_current_user)
```

* The code that manages your inputs (e.g. a Rails controller) instantiates a use case input port
  object
  - Suggest: a class that implements the `BaseParameters` interface
  - Suggest: implement the `AuthorizationParameters` interface if you want to make authorization
    part of your use case logic
  - Suggest: implement the `TargetedParameters` if your use case operates on a single object
  - Suggest: use the `TargetedParameters` entity for an out-of-the-box class that gives you all of
    these

```
  input_port = CleanArchitecture::Entities::TargetedParameters.new(
    use_case_actor,
    TargetActiveRecordClass.find(params[:id]),
    strong_params,
    persistence,
    other_settings_hash
  )
```

* The code that manages your inputs (e.g. a Rails controller) instantiates a use case object
  - Suggest: a class that implements the `UseCase` interface

```
  use_case = MyBankingApplication::UseCases::RetailCustomerMakesADeposit.new(input_port)
```
