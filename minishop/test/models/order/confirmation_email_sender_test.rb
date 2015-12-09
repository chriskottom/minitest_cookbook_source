require "test_helper"

describe Order::ConfirmationEmailSender, :model do
  describe "#after_commit" do
    include ActionMailer::TestHelper

    before do
      ActionMailer::Base.deliveries.clear
      @order = orders(:barebones)
      @sender = Order::ConfirmationEmailSender.new
    end

    it "queues a confirmation email" do
      assert_enqueued_emails 1 do
        @sender.after_commit(@order)
      end
    end

    it "sends the confirmation to the sender who placed the order" do
      assert_performed_jobs(1, only: ActionMailer::DeliveryJob) do
        @sender.after_commit(@order)
      end
      assert_emails 1

      mail = ActionMailer::Base.deliveries.first
      expect(mail.subject).must_equal "MiniShop Order Confirmation"
      expect(mail.to).must_equal [@order.email]
    end
  end
end
