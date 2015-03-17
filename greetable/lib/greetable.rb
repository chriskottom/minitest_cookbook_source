module Greetable
  def greet
    if self.respond_to?(:name)
      print "Hey, #{ self.name }."
    else
      print 'Ohai!'
    end
  end
end
