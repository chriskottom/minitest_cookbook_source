require "csv"

class OrderExtract
  CSV_HEADERS  = Order.attribute_names << "line_items"
  CSV_TMP_FILE = "/tmp/order_extract.csv"
  
  def initialize(options = { })
    @days = options[:days]
    @filename = options[:filename] || CSV_TMP_FILE
  end

  def as_file
    unless @_file_written
      CSV.open(@filename, "wb") do |csv|
        csv << CSV_HEADERS
        orders.each do |order|
          csv << ( order.attributes.values << order.line_items.count )
        end
      end
      @_file_written = true
    end

    File.new(@filename)
  end
  
  private

  def orders
    @orders ||= if @days
                  Order.where("created_at >= ?", @days.days.ago).order(:created_at)
                else
                  Order.order(:created_at)
                end
  end
end
