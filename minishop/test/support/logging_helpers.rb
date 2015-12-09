module LoggingHelpers
  def stub_logger(io)
    old_logger = Rails.logger
    Rails.logger = Logger.new io

    begin
      yield
    ensure
      Rails.logger = old_logger
    end

    io
  end
end
