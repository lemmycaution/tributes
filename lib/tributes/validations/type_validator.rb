require "tributes/validations/validator"

module Tributes
  module Validations
    class TypeValidator < Validator

      def initialize options
        raise ArgumentError, "TypeValidator only accepts single Class as options" unless options.is_a? Class
        super options
      end

      def valid? record, attr
        value = record.public_send(attr)
        value.is_a?(options)
      end

    end
  end
end