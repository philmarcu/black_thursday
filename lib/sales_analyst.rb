require 'CSV'
require 'bigdecimal'
require_relative 'itemable'
require_relative 'priceable'
require_relative 'invoiceable'
require_relative 'dayable'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'sales_engine'

class SalesAnalyst
  include Itemable
    include Priceable
      include Invoiceable
        include Dayable

  attr_reader :ic, :mc, :inv_c, :t_repo, :c, :ii
  def initialize(engine)
    @ic = engine.item_repository
    @mc = engine.merchant_repository
    @inv_c = engine.invoice_repository
    @t_repo = engine.transaction_repository
    @c = engine.customer_repository
    @ii = engine.invoice_item_repository
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

  def bottom_merchants_by_invoice_count
    invoices_per = merc_inv_hash
    merchs = invoices_per.select {|merchants, invoice| invoice < two_std_dev_below_inv_std_dev}
    merchs.keys
  end

  def top_days_by_invoice_count
    top_day = []
    day_hash = dayname_count_hash
    day_hash.each do |key, value|
      if value > one_std_dev_above_mean
        top_day << key
      end
    end
    top_day
  end

  def invoice_status(status)
    percentage(@inv_c.find_all_by_status(status).length,
    @inv_c.all.length)
  end

  def invoice_paid_in_full?(invoice_id)
   transactions = @t_repo.find_all_by_result("success")
   transactions.any? do |transaction|
     invoice_id == transaction.invoice_id
   end
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id) == true
      @ii.find_all_by_invoice_id(invoice_id).sum do |invoice|
        invoice.unit_price.to_i * invoice.quantity.to_i
      end
    end
  end

  def total_revenue_by_date(date)
    date_rev = 0
    @ii.all.each do |item|
      if item.created_at == date
        date_rev += (item.unit_price.to_i * item.quantity.to_i)
      end
    end
    date_rev
  end

  def merchants_with_pending_invoices
    pending_mercs = []
    pending = status_hash["pending"]
     @mc.all.each do |merchant|
       pending.each do |invoice|
        if merchant.id == invoice.merchant_id
          pending_mercs << merchant
        end
      end
    end
    pending_mercs
  end

  def merchants_with_only_one_item
    mercs = item_merchant_hash.select {|merchant, value| value == 1}
    mercs.keys
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      DateTime.parse(merchant.created_at).strftime('%B') == month
    end
  end

  def revenue_by_merchant(merchant_id)
    item_merchants = @ic.find_all_by_merchant_id(merchant_id)
    revenue = 0
    @ii.all.each do |inv_item|
      item_merchants.each do |item|
        if item.id == inv_item.item_id && invoice_paid_in_full?(inv_item.invoice_id)
          revenue += inv_item.quantity.to_i * item.unit_price.to_i
        end
      end
    end
    revenue
  end
end
