require_relative './item_collection'
require_relative './merchant_collection'
require_relative './sales_analyst'
require_relative './invoice_collection'

class SalesEngine

  attr_reader :item_collection,
              :merchant_collection,
              :analyst,
              :invoice_collection
  def initialize(items_path, merc_path, inv_path)
    @item_collection = ItemCollection.new(items_path)
    @merchant_collection = MerchantCollection.new(merc_path)
    @invoice_collection = InvoiceCollection.new(inv_path)
    @analyst = Analyst.new
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end
end
