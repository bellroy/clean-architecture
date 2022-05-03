# typed: strong
#
# This rbi file is bundled in the dry-monads-sorbet gem and is copied down
# into projects using the dry_monads_sorbet:update_rbi rake task.
#
# Any changes to the type annotations for Dry::Monads should be made
# in the dry-monads-sorbet gem itself in its bundled_rbi directory.

module Dry
end
module Dry::Monads
  def self.Result(error, **options); end
  def self.[](*monads); end
  def self.all_loaded?; end
  def self.constructors; end
  def self.included(base); end
  def self.known_monads; end
  def self.load_monad(name); end
  def self.register_mixin(name, mod); end
  def self.registry; end
  def self.registry=(registry); end
  extend Dry::Monads::Maybe::Mixin::Constructors
  extend Dry::Monads::Maybe::Mixin::Constructors
  extend Dry::Monads::Result::Mixin::Constructors
  extend Dry::Monads::Validated::Mixin::Constructors
end
module Dry::Monads::Curry
  def self.call(value); end
end
class Dry::Monads::UnwrapError < StandardError
  def initialize(ctx); end
end
class Dry::Monads::InvalidFailureTypeError < StandardError
  def initialize(failure); end
end
class Dry::Monads::ConstructorNotAppliedError < NoMethodError
  def initialize(method_name, constructor_name); end
end
module Dry::Monads::Transformer
  def fmap2(*args); end
  def fmap3(*args); end
end
class Dry::Monads::Maybe
  extend T::Sig
  extend T::Generic
  extend T::Helpers

  abstract!
  # sealed!

  sig do
    type_parameters(:New)
      .params(blk: T.proc.params(arg0: Elem).returns(Dry::Monads::Maybe[T.type_parameter(:out, :New)]))
      .returns(Dry::Monads::Maybe[T.type_parameter(:out, :New)])
  end
  def bind(&blk); end

  sig do
    type_parameters(:New)
      .params(blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:New)))
      .returns(Dry::Monads::Maybe[T.type_parameter(:New)])
  end
  def fmap(&blk); end

  sig do
    params(val: T.any(Elem, NilClass),
           blk: T.nilable(T.proc.returns(Elem)))
      .returns(Elem)
  end
  def value_or(val = nil, &blk); end

  sig do
    returns(Elem)
  end
  def value!; end

  sig do
    params(blk: T.proc.returns(T.untyped))
      .returns(T.self_type)
  end
  def or(&blk); end

  sig do
    type_parameters(:Error)
      .params(val: T.nilable(T.type_parameter(:Error)),
              blk: T.nilable(T.proc.returns(T.type_parameter(:Error))))
      .returns(Dry::Monads::Result[T.type_parameter(:out, :Error), Elem])
  end
  def to_result(val = nil, &blk); end

  def failure?; end
  def monad; end
  def none?; end
  def self.coerce(value); end
  def self.lift(*args, &block); end
  def self.pure(value = nil, &block); end
  def self.to_proc; end
  def some?; end
  def success?; end
  def to_maybe; end
  def to_monad; end
  include Dry::Monads::Transformer
end
class Dry::Monads::Maybe::Some < Dry::Monads::Maybe
  extend T::Sig
  extend T::Generic
  Elem = type_member

  sig {params(value: Elem).void}
  def initialize(value = nil); end
  def inspect; end
  def maybe(*args, &block); end
  def self.[](*value); end
  def self.call(*arg0); end
  def self.to_proc; end
  def to_s; end
  include Anonymous_Dry_Equalizer_33
  include Dry::Equalizer::Methods
end
module Anonymous_Dry_Equalizer_33
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
class Dry::Monads::Maybe::None < Dry::Monads::Maybe
  extend T::Sig
  extend T::Generic
  Elem = type_member

  def ==(other); end
  def deconstruct; end
  def eql?(other); end
  def hash; end
  sig {params(trace: T.untyped).void}
  def initialize(trace = T.unsafe(nil)); end
  def inspect; end
  def maybe(*arg0); end
  def or(*args); end
  def or_fmap(*args, &block); end
  def self.instance; end
  def self.method_missing(m, *arg1); end
  def to_s; end
  def trace; end
  include Dry::Core::Constants
end
module Dry::Monads::Maybe::Mixin
  include Dry::Monads::Maybe::Mixin::Constructors
end
module Dry::Monads::Maybe::Mixin::Constructors
  sig {type_parameters(:T).params(value: T.nilable(T.type_parameter(:T))).returns(Dry::Monads::Maybe[T.type_parameter(:T)])}
  def Maybe(value); end
  sig {type_parameters(:T).returns(Dry::Monads::Maybe[T.type_parameter(:out, :T)])}
  def None; end
  sig {type_parameters(:T).params(value: T.type_parameter(:T)).returns(Dry::Monads::Maybe[T.type_parameter(:T)])}
  def Some(value = nil); end
end
module Dry::Monads::Maybe::Hash
  def self.all(hash, trace = nil); end
  def self.filter(hash); end
end
class Dry::Monads::Result
  extend T::Sig
  extend T::Generic
  extend T::Helpers

  abstract!
  # sealed!

  sig do
    type_parameters(:NewSuccessType)
      .params(blk: T.proc.params(arg0: SuccessType).returns(Dry::Monads::Result[FailureType, T.type_parameter(:out, :NewSuccessType)]))
      .returns(Dry::Monads::Result[FailureType, T.type_parameter(:out, :NewSuccessType)])
  end
  def bind(&blk); end

  sig do
    type_parameters(:New)
      .params(blk: T.proc.params(arg0: SuccessType).returns(T.type_parameter(:New)))
      .returns(Dry::Monads::Result[FailureType, T.type_parameter(:New)])
  end
  def fmap(&blk); end

  sig do
    type_parameters(:Val)
      .params(val: T.nilable(T.type_parameter(:Val)), blk: T.nilable(T.proc.params(arg0: FailureType).returns(T.type_parameter(:Val))))
      .returns(T.any(SuccessType, T.type_parameter(:Val)))
  end
  def value_or(val = nil, &blk); end

  sig do
    returns(SuccessType)
  end
  def value!; end
  def to_maybe; end
  def either(f, _); end

  sig {returns(T::Boolean)}
  def success?; end

  sig {returns(T::Boolean)}
  def failure?; end

  sig {returns(FailureType)}
  def failure; end

  sig do
    type_parameters(:NewFailureType)
      .params(blk: T.proc.params(arg0: FailureType).returns(Dry::Monads::Result[T.type_parameter(:out, :NewFailureType), SuccessType]))
      .returns(Dry::Monads::Result[T.type_parameter(:out, :NewFailureType), SuccessType])
  end
  def or(&blk); end

  def monad; end
  def self.pure(value = nil, &block); end
  def success; end
  def to_monad; end
  def to_result; end
  include Anonymous_Module_34
  include Dry::Monads::Transformer
end
class Dry::Monads::Result::Success < Dry::Monads::Result
  extend T::Sig
  extend T::Generic
  FailureType = type_member
  SuccessType = type_member

  def flip; end
  def initialize(value); end
  def inspect; end
  def result(_, f); end
  def self.[](*value); end
  def self.call(*arg0); end
  def self.to_proc; end
  def success; end
  def to_s; end
  def to_validated; end
  include Anonymous_Dry_Equalizer_35
  include Dry::Equalizer::Methods
end
class Dry::Monads::Result::Failure < Dry::Monads::Result
  extend T::Sig
  extend T::Generic
  FailureType = type_member
  SuccessType = type_member

  def ===(other); end
  def failure; end
  def flip; end
  def initialize(value, trace = nil); end
  def inspect; end
  def or_fmap(*args, &block); end
  def result(f, _); end
  def self.[](*value); end
  def self.call(*arg0); end
  def self.to_proc; end
  def to_s; end
  def to_validated; end
  def trace; end
  def value_or(val = nil); end
  include Anonymous_Dry_Equalizer_36
  include Dry::Equalizer::Methods
end
class Dry::Monads::Task
  def ==(other); end
  def apply(val = nil); end
  def bind(&block); end
  def compare_promises(x, y); end
  def complete?; end
  def curry(value); end
  def discard; end
  def fmap(&block); end
  def initialize(promise); end
  def inspect; end
  def monad; end
  def or(&block); end
  def or_fmap(&block); end
  def promise; end
  def self.[](executor, &block); end
  def self.failed(exc); end
  def self.new(promise = nil, &block); end
  def self.pure(value = nil, &block); end
  def then(&block); end
  def to_maybe; end
  def to_monad; end
  def to_result; end
  def to_s; end
  def value!; end
  def value_or(&block); end
  def wait(timeout = nil); end
  include Anonymous_Module_37
end
class Dry::Monads::Try
  def error?; end
  def exception; end
  def failure?; end
  def self.[](*exceptions, &block); end
  def self.lift(*args, &block); end
  def self.pure(value = nil, exceptions = nil, &block); end
  def self.run(exceptions, f); end
  def success?; end
  def to_monad; end
  def value?; end
  include Anonymous_Module_38
end
class Dry::Monads::Try::Value < Dry::Monads::Try
  extend T::Generic
  FailureType = type_member
  SuccessType = type_member

  def bind(*args); end
  def bind_call(*args, **kwargs); end
  def catchable; end
  def fmap(*args, &block); end
  def initialize(exceptions, value); end
  def inspect; end
  def self.call(*arg0); end
  def self.to_proc; end
  def to_maybe; end
  def to_result; end
  def to_s; end
  include Anonymous_Dry_Equalizer_39
  include Dry::Equalizer::Methods
end
class Dry::Monads::Try::Error < Dry::Monads::Try
  extend T::Generic
  FailureType = type_member
  SuccessType = type_member

  def ===(other); end
  def initialize(exception); end
  def inspect; end
  def or(*args); end
  def self.call(*arg0); end
  def to_maybe; end
  def to_result; end
  def to_s; end
  include Anonymous_Dry_Equalizer_40
  include Dry::Equalizer::Methods
end
class Dry::Monads::Validated
  def bind(*arg0); end
  def self.pure(value = nil, &block); end
  def to_monad; end
  include Anonymous_Module_41
end
class Dry::Monads::Validated::Valid < Dry::Monads::Validated
  def ===(other); end
  def alt_map(_ = nil); end
  def apply(val = nil); end
  def fmap(proc = nil, &block); end
  def initialize(value); end
  def inspect; end
  def or(_ = nil); end
  def to_maybe; end
  def to_result; end
  def to_s; end
  def value!; end
  include Anonymous_Dry_Equalizer_42
  include Dry::Equalizer::Methods
end
class Dry::Monads::Validated::Invalid < Dry::Monads::Validated
  def ===(other); end
  def alt_map(proc = nil, &block); end
  def apply(val = nil); end
  def error; end
  def fmap(_ = nil); end
  def initialize(error, trace = nil); end
  def inspect; end
  def or(proc = nil, &block); end
  def to_maybe; end
  def to_result; end
  def to_s; end
  def trace; end
  include Anonymous_Dry_Equalizer_43
  include Dry::Equalizer::Methods
end
module Dry::Monads::ConversionStubs
  def self.[](*method_names); end
end
module Dry::Monads::ConversionStubs::Methods
  def self.to_maybe; end
  def self.to_result; end
  def self.to_validated; end
  def to_maybe; end
  def to_result; end
  def to_validated; end
end
class Dry::Monads::Task::Promise < Concurrent::Promise
  def on_fulfill(result); end
  def on_reject(reason); end
end
module Anonymous_Module_37
  def to_maybe(*arg0); end
  def to_result(*arg0); end
end
module Dry::Monads::Task::Mixin
  def self.[](executor); end
  include Dry::Monads::Task::Mixin::Constructors
end
module Dry::Monads::Task::Mixin::Constructors
  def Task(&block); end
end
module Anonymous_Module_34
  def to_maybe(*arg0); end
  def to_validated(*arg0); end
end
module Anonymous_Dry_Equalizer_35
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Anonymous_Dry_Equalizer_36
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Dry::Monads::Result::Mixin
  include Dry::Monads::Result::Mixin::Constructors
end
module Dry::Monads::Result::Mixin::Constructors
  sig do
    type_parameters(:FailureType, :SuccessType)
      .params(value: T.nilable(T.type_parameter(:FailureType)),
              block: T.untyped)
      .returns(Dry::Monads::Result[T.type_parameter(:FailureType),
                                   T.type_parameter(:out, :SuccessType)])
  end
  def Failure(value = nil, &block); end

  sig do
    type_parameters(:FailureType, :SuccessType)
      .params(value: T.nilable(T.type_parameter(:SuccessType)),
              block: T.untyped)
      .returns(Dry::Monads::Result[T.type_parameter(:out, :FailureType),
                                   T.type_parameter(:SuccessType)])
  end
  def Success(value = nil, &block); end
end
module Anonymous_Module_38
  def to_maybe(*arg0); end
  def to_result(*arg0); end
end
module Anonymous_Dry_Equalizer_39
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Anonymous_Dry_Equalizer_40
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Dry::Monads::Try::Mixin
  def Error(error = nil, &block); end
  def Value(value = nil, exceptions = nil, &block); end
  include Dry::Monads::Try::Mixin::Constructors
end
module Dry::Monads::Try::Mixin::Constructors
  def Try(*exceptions, &f); end
end
module Anonymous_Module_41
  def to_maybe(*arg0); end
  def to_result(*arg0); end
end
module Anonymous_Dry_Equalizer_42
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Anonymous_Dry_Equalizer_43
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Dry::Monads::Validated::Mixin
  include Dry::Monads::Validated::Mixin::Constructors
end
module Dry::Monads::Validated::Mixin::Constructors
  def Invalid(value = nil, &block); end
  def Valid(value = nil, &block); end
end
class Dry::Monads::List
  def +(other); end
  def apply(list = nil); end
  def bind(*args); end
  def coerce(other); end
  def collect; end
  def deconstruct; end
  def empty?; end
  def filter; end
  def first; end
  def fmap(*args); end
  def fold_left(initial); end
  def fold_right(initial); end
  def foldl(initial); end
  def foldr(initial); end
  def head; end
  def initialize(value, type = nil); end
  def inspect; end
  def last; end
  def map(&block); end
  def monad; end
  def reduce(initial); end
  def reverse; end
  def select; end
  def self.[](*values); end
  def self.coerce(value, type = nil); end
  def self.pure(value = nil, type = nil, &block); end
  def self.unfold(state, type = nil); end
  def size; end
  def sort; end
  def tail; end
  def to_a; end
  def to_ary; end
  def to_monad; end
  def to_s; end
  def traverse(proc = nil, &block); end
  def type; end
  def typed(type = nil); end
  def typed?; end
  def value; end
  extend Anonymous_Dry_Core_Deprecations_Tagged_44
  extend Dry::Core::Deprecations::Interface
  include Anonymous_Dry_Equalizer_45
  include Dry::Equalizer::Methods
  include Dry::Monads::Transformer
end
module Anonymous_Dry_Core_Deprecations_Tagged_44
end
module Anonymous_Dry_Equalizer_45
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
class Dry::Monads::List::ListBuilder
  def [](*args); end
  def coerce(value); end
  def initialize(type); end
  def pure(val = nil, &block); end
  def self.[](*arg0); end
  def type; end
end
module Dry::Monads::List::Mixin
  def List(value); end
end
module Dry::Monads::Do
  def self.coerce_to_monad(monads); end
  def self.for(*methods); end
  def self.halt(result); end
  def self.included(base); end
  extend Dry::Monads::Do::Mixin
end
module Dry::Monads::Do::Mixin
  def bind(monads); end
  def call; end
end
class Dry::Monads::Do::Halt < StandardError
  def initialize(result); end
  def result; end
end
module Dry::Monads::Do::All
  def self.included(base); end
  extend Dry::Monads::Do::All::InstanceMixin
end
class Dry::Monads::Do::All::MethodTracker < Module
  def extend_object(target); end
  def initialize(wrappers); end
  def wrap_method(target, method); end
  def wrappers; end
end
module Dry::Monads::Do::All::InstanceMixin
  def extended(object); end
end
class Dry::Monads::Lazy < Dry::Monads::Task
  def force!; end
  def force; end
  def inspect; end
  def self.[](executor, &block); end
  def self.new(promise = nil, &block); end
  def to_s; end
  def value!; end
end
module Dry::Monads::Lazy::Mixin
  include Dry::Monads::Lazy::Mixin::Constructors
end
module Dry::Monads::Lazy::Mixin::Constructors
  def Lazy(&block); end
end
class Dry::Monads::Result::Fixed < Module
  def included(base); end
  def self.[](error, **options); end
end
