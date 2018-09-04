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

## Clean architecture principles

### Screaming architecture - use cases as an organisational principle

Uncle Bob suggests that your source code organisation should allow developers to easily find a listing of all use cases your application provides. Here's an example of how this might look in a
Rails application.

```
- lib
  - my_banking_application
    - use_cases
      - retail_customer_opens_bank_account.rb
      - retail_customer_makes_a_deposit.rb
      - ...
```

Note that the use case name contains:

- the user role
- the action
- the (sometimes implied) subject

### Design principles

#### SRP - The Single Responsibility principle

> A function should do one, and only one, thing

We satisfy the SRP by following these rules:

- An **adapter** is solely responsible for presenting the properties of a business object, or a small number of business objects, in a known interface
- A **command** is solely responsible for completing an atomic I/O operation
- An **entity** is solely responsible for representing, in memory, a business object whos properties do not come from a single source
- An **interface** is a module that represents a contract between two classes
- A **serializer** is solely responsible for taking a business object and turning it into a representation made up of purely primitive values
- A **strategy** is an algorithm used by commands to compose atomic I/O operations
- A **use case** is solely responsible for checking whether an actor has permissions to perform a command, and executing that command if so
- A **validator** is solely responsible for validating a business object and returning a validation result

#### OCP - The Open/Closed Principle, LSP - The Liskov Substitution Principle and DIP - The Dependency Inversion Principle

> A software artefact should be open for extension but closed for modification

> A caller should not have to know the type of an object to interact with it

> Always depend on or derive from a stable abstraction, rather than a volatile concrete class

We satisfy the OCP, LSP & DIP by following these rules:

- We create a clean boundary between our business logic, our persistence layer and our application-specific classes using interfaces
- We use interfaces wherever possible, allowing concrete implementations of those interfaces to be extended without breaking the contract
- We write unit tests against interfaces, never against concrete implementations (unless interfaces don't exist)

#### ISP - The Interface Segregation Principle

> Where some actors only use a subset of methods available from an interface, the interface should be split into sub-interfaces supporting each type of caller

We satisfy the ISP by following these rules:

- Each functional area of our code is split into folders (under `lib` in Rails projects)
- Each functional area defines its own interfaces
- Interfaces are not shared between functional areas

### Component cohesion

#### REP - The Reuse/Release Equivalence Principle, CCP - The Common Closure Principle & CRP - The Common Reuse Principle

> Classes and modules that are grouped together into a component should be releasable together

> Gather into components those changes the change for the same reasons and at the same times.

> Classes and modules that tend to be reused together should be placed in the same component

We satisfy the REP, CCP and CRP by:

- Having team discussions whenever we make decisions about what a new functional area should be called and what it should contain
- Ensuring that none of our functional areas make direct reference back to the parent application
- Splitting functional areas out into gems when those functional areas change at a different rate than the rest of the codebase
- Splitting functional areas out into standalone applications when it makes sense to do so

### Component coupling

#### ADP - The Acyclic Dependencies Principle

> Don't create circular dependencies

I don't think I need to explain this. Just don't do it. I like explicitly including dependencies using `require` because it actually prevents you from doing this. Rails, in so many ways, makes one lazy.

#### SDP - The Stable Dependencies Principle

> A component always have less things depending on it than it depends on

We satisfy the SDP by:

- Putting sensible abstractions in place that adhere to the Single Responsibility principle
- Not sharing abstractions and entities between multiple functional areas

#### SAP - The Stable Abstractions Principle

> A component should be as abstract as it is stable

We satisfy the SAP by:

- Thinking hard about the methods and parameters we specify in our interfaces. Are they solving for a general problem? Are we likely to have to change them when requirements change, and how we can avoid that?

## Practical suggestions for implementation

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
