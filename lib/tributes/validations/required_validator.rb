require "tributes/validations/validator"

module Tributes
  module Validations
    class RequiredValidator < Validator

      def valid? record, attr_name
        value = record.public_send(attr_name)
        value.respond_to?(:empty?) ? !value.empty? : !value.nil?
      end

    end
  end
end