require 'CSV'
require 'bigdecimal'
require_relative 'itemable'
require_relative 'priceable'
require_relative 'invoiceable'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_engine'

class SalesAnalyst
  include Itemable
    include Priceable
      include Invoiceable

  attr_reader :ic, :mc, :inv_c
  def initialize(engine)
    @ic = engine.item_repository
    @mc = engine.merchant_repository
    @inv_c = engine.invoice_repository
  end

  def average_items_per_merchant
    item_total = @ic.all.length
    merc_total = @mc.all.length
    (item_total/ merc_total.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    variance = variance_of_items
    std_dev = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    @mc.all.find_all do |merchant|
      items = @ic.find_all_by_merchant_id(merchant.id)
      items.count > one_std_dev_above_merchant_std_dev
    end
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
    Math.sqrt(variance).round(2)
   end

  def average_average_price_per_merchant
    merc_total = @mc.all.size
    sum = collect_average_item_prices.sum.to_f
    final_output = (sum / merc_total)
    # BigDecimal(final_output) .round(2).to_s("F").to_f
  end

  def golden_items
    @ic.all.find_all {|item| item.unit_price.to_i > two_std_dev_above_prices_per_item}
  end

  def average_invoices_per_merchant
    inv_total = @inv_c.all.length
    merc_total = @mc.all.length
    (inv_total / merc_total.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    variance = invoice_variance
    Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    invoices_per = merc_inv_hash
    merchs = invoices_per.select {|merchants, invoice| invoice > two_std_dev_above_inv_std_dev}
    merchs.keys
  end
end
