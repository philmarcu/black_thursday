require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :transaction_repository,
              :customer_repository,
              :invoice_item_repository,
              :analyst
  def initialize(data)
    @item_repository = ItemRepository.new(data[:items])
    @merchant_repository = MerchantRepository.new(data[:merchants])
    @invoice_repository = InvoiceRepository.new(data[:invoices])
    @transaction_repository = TransactionRepository.new(data[:transactions])
    @customer_repository = CustomerRepository.new(data[:customers])
    @invoice_item_repository = InvoiceItemRepository.new(data[:invoice_items])
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end
end
