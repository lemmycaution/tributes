require "minitest_helper"
require "tributes/validations/type_validator"

module Tributes
  module Validations
    class TestTypeValidator < Minitest::Test

      class Person
        attr_accessor :first_name, :last_name, :age, :last_login
      end

      def setup
        @string_validator = TypeValidator.new(String)
        @numeric_validator = TypeValidator.new(Numeric)
        @time_validator = TypeValidator.new(Time)
        @person = Person.new
        @person.first_name = 'Bob'
        @person.age = 12
        @person.last_login = Time.now
      end

      def test_options
        assert_raises(ArgumentError) { TypeValidator.new }
      end

      def test_nil
        assert @string_validator.valid? @person, :last_name
      end

      def test_string_valid?
        assert @string_validator.valid? @person, :first_name
        refute @string_validator.valid? @person, :age
      end
      
      def test_numeric_valid?
        assert @numeric_validator.valid? @person, :age
        refute @numeric_validator.valid? @person, :first_name
      end

      def test_time_valid?
        assert @time_validator.valid? @person, :last_login
        refute @time_validator.valid? @person, :age
      end

    end
  end
end