require 'test_helper'

class GreetableTest < Minitest::Test
  def test_generic_greeting_delivered
    greetable = Object.new
    greetable.extend(Greetable)

    assert_output 'Ohai!' do
      greetable.greet
    end
  end

  def test_personalized_greeting_delivered_using_object
    assert_output('Hey, Matz.') do
      greetable = Object.new
      greetable.extend(Greetable)
      class << greetable
        def name
          'Matz'
        end
      end
      greetable.greet
    end
  end

  def test_personalized_greeting_delivered_using_struct
    assert_output('Hey, Matz.') do
      greetable = Struct.new(:name) do
        include Greetable
      end.new("Matz")
      greetable.greet
    end
  end
end
