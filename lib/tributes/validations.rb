require 'tributes/validations/required_validator'
require 'tributes/validations/type_validator'

module Tributes
  module Validations

    module ClassMethods

      ##
      # Class method takes attribute name and hash of validator and their options
      #
      # params:
      # - attr_name, Symbol, attribute name
      # - validators, Hash, validator name and options
      # Example: 
      # class Person
      #   include Tributes
      #   include Tributes::Validations
      #   tributes :name, :age
      #   validates :name, required: true, type: String
      #   validates :age, required: true, type: Numeric
      # end
      # person = Person.new(name: 'Bob')
      # person.valid?
      #  => false
      # person.errors
      #  => [{:age=>:required}, {:age=>:numeric}]

      def validates attr_name, validators = {}
        return unless validators.any?
        raise ArgumentError, "#{attr_name} should be defined by tributes class method" unless tributes.include? attr_name
        validations[attr_name] = validators.map{ |kind, options| 
          begin validator_class = const_get "#{kind.to_s.capitalize}Validator"
            validator_class.new options
          rescue NameError
            raise ArgumentError, "#{kind} validator not defined"
          end
        }
      end
      
      # keep record of tributes to prevent assigning validations on dynamic attributes
      def tributes *attrs
        if attrs.empty? 
          @tributes ||= []
        else  
          @tributes = attrs
          super *attrs
        end  
      end

      def validations
        @validations ||= {}
      end
    end

    def self.included base
      base.extend ClassMethods
    end

    def valid?
      !self.class.validations.map{ |attr_name, validators|
        validators.map{ |validator|
          errors << { attr_name => validator.kind } unless valid = validator.valid?(self, attr_name)
          valid
        }
      }.flatten.include?(false)
    end

    def errors
      @errors ||= []
    end

  end
end