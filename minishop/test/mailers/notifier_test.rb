require "test_helper"

describe Notifier do
  let(:order)  { orders(:barebones) }

  describe "#order_received" do
    it "order_received" do
      mail = Notifier.order_received(order)
      expect(mail.subject).must_equal "MiniShop Order Confirmation"
      expect(mail.to).must_equal [order.email]
      expect(mail.from).must_equal ["postman@example.com"]
      expect(mail.body.encoded).must_match "Thank you for your recent order from MiniShop"
    end
  end

  describe "#order_shipped" do
    it "order_shipped" do
      mail = Notifier.order_shipped(order)
      expect(mail.subject).must_equal "Your MiniShop Order Has Shipped"
      expect(mail.to).must_equal [order.email]
      expect(mail.from).must_equal ["postman@example.com"]
      expect(mail.body.encoded).must_match "we've shipped your recent order"
    end
  end
end
