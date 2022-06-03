require_relative './item_collection'
require_relative './merchant_collection'
require_relative './sales_analyst'

class SalesEngine

  attr_reader :item_collection,
              :merchant_collection,
              :analyst
  def initialize(items_path, merc_path)
    @item_collection = ItemCollection.new(items_path)
    @merchant_collection = MerchantCollection.new(merc_path)
    @analyst = Analyst.new
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants])
  end
end
