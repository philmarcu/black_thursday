require 'CSV'
require_relative "invoice_item"

class InvoiceItemRepository
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(:id => row[:id], :item_id => row[:item_id], :invoice_id => row[:invoice_id], :quantity => row[:quantity], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at])
    end
  end

  def find_by_id(id)
    @all.find {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(item_id)
    @all.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def create(attributes)
    attributes[:invoice_id] = (@all.last.invoice_id.to_i + 1).to_s
    attributes[:item_id] = (@all.last.item_id.to_i + 1).to_s
    attributes[:id] = (@all.last.id.to_i + 1).to_s
    quantity = attributes[:quantity]
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = InvoiceItem.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)
    updated = self.find_by_id(id)
    updated.update_info(attributes)
  end

  def delete(id)
    @all.delete_if do |invoice|
      invoice.id == id
    end
  end

end
