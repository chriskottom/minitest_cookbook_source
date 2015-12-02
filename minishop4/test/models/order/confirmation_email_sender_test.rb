require "test_helper"

describe Order::ConfirmationEmailSender, :model do

  describe "#after_commit" do
    it "sends a confirmation email to the user who placed the order" do
      order = orders(:barebones)
      sender = Order::ConfirmationEmailSender.new

      lambda {
        sender.after_commit(order)
      }.must_change "ActionMailer::Base.deliveries.count"

      mail = ActionMailer::Base.deliveries.last
      mail[:subject].value.must_equal "MiniShop Order Confirmation"
    end
  end
end
