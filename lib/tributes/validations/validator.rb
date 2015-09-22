module Tributes
  module Validations
    class Validator
      attr_reader :options

      def initialize options = {}
        @options = options.freeze
      end

      def valid? record, attr, options
        raise NotImplementedError
      end

      def kind
        self.class.name.split('::').last.gsub('Validator','').downcase.to_sym
      end
    end
  end
end