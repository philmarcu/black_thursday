require 'CSV'
require './lib/item'
require './lib/merchant'
require './lib/sales_engine'

class Analyst < SalesEngine
  def initialize(items_path, merc_path)
    super
    @ic = @item_collection.all
    @mc = @merchant_collection.all
  end

  def average_items_per_merchant
    item_total = @ic.length
    merc_total = @mc.length
    (item_total / merc_total.to_f).round(2)
  end

end
