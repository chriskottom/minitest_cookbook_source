require 'test_helper'

class GreetableTest < Minitest::Test
  ThingWithName = Struct.new(:name) do
    include Greetable
  end

  def test_generic_greeting_delivered
    @greetable = Object.new
    @greetable.extend(Greetable)

    assert_output 'Ohai!' do
      @greetable.greet
    end
  end

  def test_personalized_greeting_delivered
    # @greetable = ThingWithName.new('Matz')
    @greetable = Object.new
    @greetable.extend(Greetable)
    class << @greetable
      def name
        'Matz'
      end
    end

    assert_output('Hey, Matz.') do
      @greetable.greet
    end
  end
end
