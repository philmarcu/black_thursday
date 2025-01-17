require 'CSV'
require_relative "invoice"
require_relative "findable"

class InvoiceRepository
  include Findable
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(:id => row[:id], :customer_id => row[:customer_id], :merchant_id => row[:merchant_id], :status => row[:status], :created_at => row[:created_at], :updated_at => row[:updated_at])
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_status(status)
    @all.find_all {|invoice| invoice.status == status}
  end

  def create(attributes)
    attributes[:customer_id] = (@all.last.customer_id.to_i + 1 + 1).to_s
    attributes[:id] = (@all.last.id.to_i + 1).to_s
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Invoice.new(attributes)
    @all.push(new)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
