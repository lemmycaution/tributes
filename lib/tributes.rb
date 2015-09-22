##
# This module provides a functionality like native ruby attr_accessor method.
# Created as a response to https://gist.github.com/burlesona/4f5f2a00a731af547e5b.

require 'json'

module Tributes

  module ClassMethods

    ##
    # Class method takes array of attribute names and creates getter/setter methods for them
    #
    # params:
    # - attrs, Array of symbols
    # Example: 
    # class Person
    #   include Tributes
    #   tributes :name, :email
    # end
    # person = Person.new(name: 'Bob', email: 'bob@email.com')
    # puts person.name
    # => 'Bob'
    
    def tributes *attrs
      attrs.each { |attr| 
        define_method(:"#{attr}=") { |val| _attributes[attr] = val }
        define_method(attr) { _attributes[attr] }
      }
    end

  end
  
  # Simple hook to extend base class
  def self.included base
    base.extend(ClassMethods)
  end
  
  # Initializer assigns attribute data from given hash to newly created instance
  def initialize new_attributes = {}
    _assign_attributes new_attributes
  end

  # dumps attributes hash as json string
  def to_json
    JSON.dump _attributes
  end

  # loads attributes hash from json string
  def from_json string
    _assign_attributes JSON.parse(string)
  end

  private
  
  def _assign_attributes new_attributes
    raise ArgumentError, 'passed argument has to be a Hash' unless new_attributes.respond_to? 'keys'
    # declare members
    self.class.tributes *new_attributes.keys
    # set actual data
    new_attributes.each { |k,v| public_send("#{k}=", v) }
  end

  def _attributes
    @_attributes ||= {}
  end

  def _attributes= new_attributes
    @_attributes = new_attributes
  end
end