require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :analyst,
              :invoice_repository
  def initialize(items_path, merc_path, inv_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merc_path)
    @invoice_repository = InvoiceRepository.new(inv_path)
    @analyst = SalesAnalyst.new
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end
end
