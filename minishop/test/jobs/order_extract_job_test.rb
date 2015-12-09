require "test_helper"
require "stringio"

class OrderExtractJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  include LoggingHelpers
  
  setup do
    ActionMailer::Base.deliveries.clear
  end

  test "sends a message with the extract file" do
    assert_no_emails
    OrderExtractJob.perform_now

    assert_emails 1
    message = ActionMailer::Base.deliveries.last
    assert_equal %w( admin@example.com ), message.to
    assert_equal %w( root@example.com ), message.from
    assert_equal "Order Extract - #{ Date.today.to_s }", message.subject

    attachments = message.attachments
    assert_equal 1, attachments.count
    assert_equal "order_extract.csv", attachments[0].filename
  end

  test "logs errors received during message delivery" do
    io = StringIO.new
    kaboom = -> (data) { raise AttachmentEmail::DeliveryError,
                               "Server busy, no dice" }
    stub_logger(io) do
      AttachmentEmail.stub(:send, kaboom) do
        OrderExtractJob.perform_now
      end
    end

    expected_msg = "Order Extract: Server busy, no dice"
    expect(io.string).must_match expected_msg
  end
end
