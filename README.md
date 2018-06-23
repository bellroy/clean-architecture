# Bellroy Liquid Markup

This gem provides:
- custom liquid filters and tags to be used in Liquid markup in the V3 CMS

The only reason this gem should change is:
- if we need new functionality in our Liquid markup

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bellroy-Liquid', git: 'git@github.com:tricycle/bellroy-liquid.git'
```

And then execute:

    $ bundle install
    $ bundle binstubs bellroy-liquid

## Implementation

In your code, you will need to implement two classes that implement the
`Bellroy::Liquid::Interfaces::RenderContext` and
`Bellroy::Liquid::Interfaces::DataQuery` interfaces. Instances of the two classes will need to be
passed into the `Bellroy::Liquid::Renderer#render` properties so that the custom Liquid tags
in this gem can access information about the visitor and access data from the product configuration
and content management system.
