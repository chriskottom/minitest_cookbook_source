require "test_helper"

feature "Order Extracts" do
  include ActionMailer::TestHelper
  
  before do
    ActionMailer::Base.deliveries.clear
  end

  scenario "generate and send an extract" do
    visit login_path
    fill_in("Name", with: "lumbergh")
    fill_in("Password", with: "secret")
    click_button("Login")

    visit orders_path

    perform_enqueued_jobs do
      assert_no_emails
      click_button("Generate Order Extract")

      assert_emails 1
      message = ActionMailer::Base.deliveries.last
      assert_equal %w( admin@example.com ), message.to
      assert_equal %w( root@example.com ), message.from
      assert_equal "Order Extract - #{ Date.today.to_s }", message.subject

      attachments = message.attachments
      assert_equal 1, attachments.count
      assert_equal "order_extract.csv", attachments[0].filename
    end

    expected_message = "Your extract is now being generated and sent."
    expect(page).must_have_css("#notice", text: expected_message)
  end
end
