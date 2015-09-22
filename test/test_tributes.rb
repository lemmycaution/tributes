require "./lib/tributes"
require "minitest/autorun"

class TestTributes < Minitest::Test

  class Person
    include Tributes
  end
  
  class Book
    include Tributes
    tributes :title, :author
  end
  
  def test_tributes_class_macro
    book = Book.new(author: "Christof Koch")
    refute book.title
    assert_equal "Christof Koch", book.author
    book.title = "Consciousness"
    assert_equal "Consciousness", book.title
  end

  def test_attributes_assignment_on_initialisation
    person = Person.new(name: 'Bob', age: 12)
    assert_equal 'Bob', person.name
    assert_equal 12, person.age
  end

  def test_to_json
    assert_equal '{"name":"Bob","age":12}', Person.new(name: 'Bob', age: 12).to_json
  end

  def test_from_json
    older = Person.new
    older.from_json '{"age":20}'
    assert_equal 20, older.age
  end
  
  def test_invalid_attributes
    assert_raises(ArgumentError) { Person.new 123 }
  end

end