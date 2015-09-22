require "tributes/validations/validator"

module Tributes
  module Validations
    class TypeValidator < Validator

      def initialize options
        raise ArgumentError, "TypeValidator only accepts single Class as options" unless options.is_a? Class
        super options
      end

      def valid? record, attr_name
        raise ArgumentError, "Attribute `#{attr_name}` not found" unless record.respond_to? attr_name
        value = record.public_send(attr_name)
        value.nil? || value.is_a?(options)
      end

      def kind
        options.name.downcase.to_sym
      end

    end
  end
end