require "minitest_helper"
require "tributes/validations/validator"

module Tributes
  module Validations
    class TestValidator < Minitest::Test

      class TestValidator < Validator; end

      def test_options
        validator = TestValidator.new(max_length: 1)
        assert 1, validator.options[:max_length]
        assert_raises(RuntimeError) { validator.options[:max_length] = 2 }
      end

      def test_kind
        validator = TestValidator.new
        assert_equal :test, validator.kind
      end

    end
  end
end