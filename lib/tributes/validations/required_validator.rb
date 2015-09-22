require "tributes/validations/validator"

module Tributes
  module Validations
    class RequiredValidator < Validator

      def valid? record, attr
        value = record.public_send(attr)
        value.respond_to?(:empty?) ? !value.empty? : !value.nil?
      end

    end
  end
end