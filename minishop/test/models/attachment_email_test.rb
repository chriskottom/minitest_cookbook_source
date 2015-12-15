require "test_helper"

describe AttachmentEmail, :model do
  include ActionMailer::TestHelper

  let(:options) {
    { to: "foo@bar.com", from: "bat@baz.com",
      subject: "This is a subject...", body: "This is a message..." }
  }
  let(:filename)    { file_fixture("sample.txt") }
  let(:attachments) { [File.new(filename)] }
  let(:subject)     { AttachmentEmail.new(options: options,
                                          attachments: attachments) }
  
  before do
    ActionMailer::Base.deliveries.clear
  end

  it "sends one email" do
    subject.send
    assert_emails 1
  end
  
  it "sends email with the requested options" do
    subject.send
    message = ActionMailer::Base.deliveries.last
    expect(message.to).must_equal [options[:to]]
    expect(message.from).must_equal [options[:from]]
    expect(message.subject).must_equal options[:subject]
    expect(message.body.to_s).must_equal options[:body]
  end

  it "sends email with the requested attachments" do
    subject.send
    message = ActionMailer::Base.deliveries.last
    expect(message.attachments.count).must_equal 1

    attachment = message.attachments["sample.txt"]
    expect(attachment).wont_be_nil
    expect(attachment.body.to_s).must_equal File.read(filename)
  end

  describe "given no attachments" do
    let(:attachments) { [] }
    
    it "sends email with no attachments" do
      subject.send
      message = ActionMailer::Base.deliveries.last
      expect(message.attachments).must_be_empty
    end
  end
end
