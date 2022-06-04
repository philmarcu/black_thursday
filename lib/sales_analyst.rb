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
    items_per.map do |merchant, items|
      items.count
    end
  end

  def square_diffs_of_total_items
    mean = average_items_per_merchant
    square_diffs = []
    total_items_per_merchant.each do |item|
      square = (item - mean) ** 2
      square_diffs << square
    end
    square_diffs
  end

  def sum_of_total_item_nums
    sum_squares = 0
    square_diffs_of_total_items.each do |item|
      sum_squares += item
    end
    sum_squares
  end

  def variance_of_items
    sum_squares = sum_of_total_item_nums
    merc_total = @mc.all.length
    variance = (sum_squares / merc_total.to_f)
  end

  def average_items_per_merchant_standard_deviation
    variance = variance_of_items
    std_dev = Math.sqrt(variance).round(2)
  end
end
