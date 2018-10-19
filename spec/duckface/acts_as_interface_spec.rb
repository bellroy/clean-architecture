# frozen_string_literal: true

require 'clean_architecture/all'
require 'duckface'
require_relative '../support/shared_examples/an_interface.rb'

module Duckface
  describe ActsAsInterface do
    all_classes = ObjectSpace.each_object(Class)

    all_interfaces = ObjectSpace.each_object(Module).select do |klass|
      !klass.name.nil? && klass.name.split('::').include?('Interfaces')
    end

    all_interfaces.each do |interface|
      implementing_classes = all_classes.select do |klass|
        klass.included_modules.include?(interface)
      end
      implementing_classes.each do |implementing_class|
        describe implementing_class do
          it_behaves_like 'it implements', interface
        end
      end

      describe interface do
        it_behaves_like 'an interface'
      end
    end
  end
end
