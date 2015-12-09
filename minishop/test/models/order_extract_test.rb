require "test_helper"

describe OrderExtract, :model do
  let(:extract) { OrderExtract.new }
  let(:file)    { extract.as_file }

  it "should be in CSV format" do
    csv = CSV.open(file.to_path)
    expect(csv.first).must_equal OrderExtract::CSV_HEADERS
  end

  it "should include a record for each order" do
    csv = CSV.open(file.to_path, headers: true)
    csv_ids = csv.map { |row| row["id"].to_i }.sort
    expect(csv_ids).must_equal Order.order(:id).pluck(:id)
  end

  it "should write to a standard location" do
    expect(file.to_path).must_equal OrderExtract::CSV_TMP_FILE
  end

  describe "given a number of days" do
    let(:days)    { 10 }
    let(:extract) { OrderExtract.new(days: days) }

    it "should include only recent records" do
      csv = CSV.open(file.to_path, headers: true)
      csv_ids = csv.map { |row| row["id"].to_i }.sort
      expect(csv_ids).must_include orders(:barebones).id
      expect(csv_ids).wont_include orders(:old).id
    end
  end

  describe "given an explicit output file" do
    let(:filename) { "/tmp/order_report.csv" }
    let(:extract)  { OrderExtract.new(filename: filename) }

    it "should write to a standard location" do
      expect(file.to_path).must_equal filename
    end
  end
end
