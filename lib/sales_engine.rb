require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :analyst,
              :invoice_repository
  def initialize(data)
    @item_repository = ItemRepository.new(data[:items])
    @merchant_repository = MerchantRepository.new(data[:merchants])
    @invoice_repository = InvoiceRepository.new(data[:invoices])
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end
end
