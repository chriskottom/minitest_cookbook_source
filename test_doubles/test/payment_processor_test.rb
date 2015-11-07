require 'test_helper'

class Payment
  def initialize(amount: 0.00, currency: "USD")
    @amount = amount
    @currency = currency
  end
end

class PaymentProcessor
  def initialize(options = {})
    @payment = options[:payment]
    @gateway = options[:gateway]
  end

  def execute
    @gateway.process(@payment)
  end
end

module Stripe
  class PaymentGateway

    # uh-oh, no process method...

  end
end

class PaymentProcessorTest < Minitest::Test
  def setup
    @payment = Payment.new(amount: 20.00, currency: "USD")
    @real_gateway = Stripe::PaymentGateway.new
    @gateway = Minitest::Mock.new(@real_gateway)
  end

  def test_payment_sent_to_gateway
    processor = PaymentProcessor.new(payment: @payment,
                                     gateway: @gateway)
    @gateway.expect(:process, true, [@payment])
    processor.execute
    @gateway.verify
  end
end
