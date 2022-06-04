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


  def total_items_per_merchant
    items_per = @ic.group_by_merchant_id
    items_per.map {|merchant, items| items.count}
  end

  def square_diffs_of_total_items
    mean = average_items_per_merchant
    total_items_per_merchant.map {|item| square = (item - mean) ** 2}
  end

  def sum_of_total_item_nums
    square_diffs_of_total_items.sum {|item| item}
  end

  def variance_of_items
    sum_squares = sum_of_total_item_nums
    merc_total = @mc.all.length
    variance = (sum_squares / (merc_total.to_f - 1))
  end

  def average_items_per_merchant_standard_deviation
    variance = variance_of_items
    std_dev = Math.sqrt(variance).round(2)
  end
end
