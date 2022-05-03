# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `dry-monads-sorbet` gem.
# Please instead update this file by running `typecheck update`.

# typed: true

class Dry::Monads::Maybe
  include(::Dry::Monads::Transformer)

  def failure?; end
  def monad; end
  def none?; end
  def some?; end
  def success?; end
  def to_maybe; end
  def to_monad; end

  class << self
    def coerce(value); end
    def lift(*args, &block); end
    def pure(value = T.unsafe(nil), &block); end
    def to_proc; end
  end
end

class Dry::Monads::Result
  include(::Dry::Monads::Transformer)

  def failure; end
  def monad; end
  def success; end
  def to_monad; end
  def to_result; end

  class << self
    def pure(value = T.unsafe(nil), &block); end
  end
end

module DryMonadsSorbet
end