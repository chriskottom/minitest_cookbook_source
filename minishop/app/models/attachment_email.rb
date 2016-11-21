require 'net/smtp'

class AttachmentEmail
  SMTP_ERRORS = [
    IOError, Net::SMTPAuthenticationError, Net::SMTPServerBusy,
    Net::SMTPUnknownError, Timeout::Error,
  ]

  class DeliveryError < RuntimeError; end
  
  def self.send(attachments: [], options: {})
    email = self.new(attachments: attachments, options: options)
    email.send
  end

  def initialize(attachments: [], options: {})
    @attachments = attachments
    @email_options = options
  end

  def send
    message = ActionMailer::Base.mail @email_options
    @attachments.each do |file|
      filename = File.basename(file.path)
      message.attachments[filename] = { content: file.read }
    end
    message.deliver
  rescue *SMTP_ERRORS => e
    raise DeliveryError, "Message could not be sent - #{ e.message }"
  end
end
