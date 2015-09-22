require "minitest_helper"
require "tributes/validations/required_validator"

module Tributes
  module Validations
    class TestRequiredValidator < Minitest::Test

      class Person
        attr_accessor :name, :age
      end

      def test_valid?
        validator = RequiredValidator.new
        person = Person.new
        person.name = 'Bob'

        assert validator.valid? person, :name
        refute validator.valid? person, :age
      end

    end
  end
end