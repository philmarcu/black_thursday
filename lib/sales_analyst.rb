require 'CSV'
require 'bigdecimal'
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

  def one_std_dev_above_merchant_std_dev
    mean= average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    (mean + std_dev)
  end

  def merchants_with_high_item_count
    merc_total = @mc.all
    merc_total.find_all do |merchant|
      items = @ic.find_all_by_merchant_id(merchant.id)
      items.count > one_std_dev_above_merchant_std_dev
    end
  end

  def sum_of_unit_prices(merchant_id)
    sum_per_merc = 0
    @ic.all.each do |item|
      if item.merchant_id == merchant_id
        sum_per_merc += item.unit_price.to_i
      end
    end
    sum_per_merc
  end

  def item_count_for_merchant(merchant_id)
    item_count = 0
    items_per = @ic.group_by_merchant_id
    items_per.each do |merchant, items|
      items.each do |item|
        if item.merchant_id == merchant_id
          item_count += 1
        end
      end
    end
    item_count
  end

  def average_item_price_for_merchant(merchant_id)
    sum = sum_of_unit_prices(merchant_id)
    count = item_count_for_merchant(merchant_id)
    final_output = (sum / count.to_f)
    avg = (sum / count.to_f).to_i.size
    BigDecimal(final_output, avg)
  end
end
