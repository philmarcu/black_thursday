module Mathable

  def total_items_per_merchant
    items_per = @ic.group_by_merchant_id
    items_per.map {|merchant, items| items.count}
  end

  def square_diffs_of_total_items
    mean = average_items_per_merchant
    total_items_per_merchant.map {|item| (item - mean) ** 2}
  end

  def sum_of_total_item_nums
    square_diffs_of_total_items.sum {|item| item}
  end

  def variance_of_items
    sum_squares = sum_of_total_item_nums
    merc_total = @mc.all.length
    (sum_squares / (merc_total.to_f - 1))
  end

  def one_std_dev_above_merchant_std_dev
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    (mean + std_dev)
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

  def sum_of_unit_prices(merchant_id)
    sum_per_merc = 0
    @ic.all.each do |item|
      if item.merchant_id == merchant_id
        sum_per_merc += item.unit_price.to_i
      end
    end
    sum_per_merc
  end

# --- Temporary Divider --- #

  def collect_average_item_prices
    avg_price_arr = []
    @mc.all.each do |merchant|
      avg_price_arr << average_item_price_for_merchant(merchant.id)
    end
    avg_price_arr
  end

  def avg_price_all
    total = @ic.all.map {|item| item.unit_price}
    sum = total.sum {|price| price.to_i}
    avg = (sum / @ic.all.size.to_f)
  end

  def square_price_diffs
    total = @ic.all.map {|item| item.unit_price}
    mean = avg_price_all
    total.map {|price| (price.to_i - mean) ** 2 }
  end

  def sum_of_total_price_diffs
    square_price_diffs.sum {|price| price}
  end

  def price_variance
    sum = sum_of_total_price_diffs
    (sum / (@ic.all.size.to_f - 1))
  end

  def two_std_dev_above_prices_per_item
    mean = avg_price_all
    std_dev = std_dev_of_prices_per_item
    (((mean + std_dev) * 2).to_f).round(2)
  end

  def merc_invoice_count
  invoices_per = @inv_c.group_by_merchant_id
  invoices_per.map {|merchant, invoice| invoice.count}
  end

  def square_sum_of_total_invoices
    mean = average_invoices_per_merchant
    merc_invoice_count.map {|invoice| (invoice - mean) ** 2}
    sum = merc_invoice_count.sum {|invoice| invoice}
  end

  def invoice_variance
    sum = square_sum_of_total_invoices
    merc_total = @mc.all.size
    (sum / (merc_total.to_f - 1))
  end
end
