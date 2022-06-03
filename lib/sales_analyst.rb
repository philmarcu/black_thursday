require 'CSV'
require_relative 'item_collection'
require_relative 'merchant_collection'
require_relative 'sales_engine'

class Analyst

  attr_reader :ic, :mc
  def initialize
    @ic = ItemCollection.new("./data/items.csv")
    @mc = MerchantCollection.new("./data/merchants.csv")
  end

  def average_items_per_merchant
    item_total = @ic.all.length
    merc_total = @mc.all.length
    (item_total / merc_total.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
  end

end
