require 'CSV'
require 'bigdecimal'
require_relative 'mathable'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_engine'

class SalesAnalyst
  include Mathable

  attr_reader :ic, :mc, :inv_c
  def initialize
    @ic = ItemRepository.new("./data/items.csv")
    @mc = MerchantRepository.new("./data/merchants.csv")
    @inv_c = InvoiceRepository.new("./data/invoices.csv")
  end

  def one_std_dev_above_merchant_std_dev
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    (mean + std_dev)
  end

  def merchants_with_high_item_count
    @mc.all.find_all do |merchant|
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
    avg = (sum / count)
    # BigDecimal(final_output, avg)
  end

  def std_dev_of_prices_per_item
    variance = price_variance
    std_dev = Math.sqrt(variance).round(2)
   end

  def average_average_price_per_merchant
    merc_total = @mc.all.size
    sum = collect_average_item_prices.sum.to_f
    final_output = (sum / merc_total)
    # BigDecimal(final_output) .round(2).to_s("F").to_f
  end

  def two_std_dev_above_prices_per_item
    mean = avg_price_all
    std_dev = std_dev_of_prices_per_item
    (((mean + std_dev) * 2).to_f).round(2)
  end

  def golden_items
    @ic.all.find_all {|item| item.unit_price.to_i > two_std_dev_above_prices_per_item}
  end
end
