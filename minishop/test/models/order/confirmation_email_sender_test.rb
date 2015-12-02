require "test_helper"

describe Order::ConfirmationEmailSender, :model do
  describe "#after_commit" do
    it "sends a confirmation email to the user who placed the order" do
      order = orders(:barebones)
      sender = Order::ConfirmationEmailSender.new

      assert_difference "ActionMailer::Base.deliveries.count" do
        sender.after_commit(order)
      end

      mail = ActionMailer::Base.deliveries.last
      expect(mail[:subject].value).must_equal "MiniShop Order Confirmation"
    end
  end
end
