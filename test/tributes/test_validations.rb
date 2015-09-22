require "minitest_helper"
require "tributes/validations"

module Tributes
  class TestValidations < Minitest::Test

    class Person
      include Tributes
      include Validations
      tributes :first_name, :last_name, :age
      validates :first_name, required: true, type: String
      validates :last_name, required: true, type: String
      validates :age, type: Numeric
    end

    def setup
      @invalid = Person.new
      @valid = Person.new(first_name: 'Bob', last_name: 'Kinsky', age: 12)
      @invalid.valid?
    end

    def test_undefined_validator
      assert_raises(ArgumentError) { 
        Person.public_send :validates, :email, format: /fake@emailregex/
      }
    end

    def test_undefined_field
      assert_raises(ArgumentError) {
        Person.public_send :validates, :approved, type: TrueClass
      }
    end

    def test_valid
      refute @invalid.valid?
      assert @valid.valid?
    end

    def test_required
      assert_equal :required, @invalid.errors[0][:first_name]
    end

    def test_type
      @invalid.first_name = 12
      @invalid.age = ""
      @invalid.valid?
      assert_equal :string, @invalid.errors[2][:first_name]
      assert_equal :numeric, @invalid.errors[4][:age]
    end

  end
end