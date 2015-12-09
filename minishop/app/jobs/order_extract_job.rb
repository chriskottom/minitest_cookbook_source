class OrderExtractJob < ApplicationJob
  DEFAULT_EXTRACT_OPTIONS = { days: 30 }
  EMAIL_OPTIONS = {
    to: "admin@example.com",
    from: "root@example.com",
    subject: "Order Extract",
    body: "",
    content_type: "text/html"
  }
  
  queue_as :default

  rescue_from AttachmentEmail::DeliveryError do |error|
    Rails.logger.fatal "Order Extract: #{ error.message }"
  end

  def perform(options = DEFAULT_EXTRACT_OPTIONS)
    extract = OrderExtract.new options
    message = AttachmentEmail.send(attachments: attachments(extract),
                                   options: email_options)
  end

  private
  
  def email_options
    date_str = Date.today.to_s
    EMAIL_OPTIONS.merge(subject: "Order Extract - #{ date_str }")
  end

  def attachments(extract)
    [ extract.as_file ]
  end
end
