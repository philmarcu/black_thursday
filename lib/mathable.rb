module Mathable

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
    total_items_per_merchant.map {|item| (item - mean) ** 2}
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
    variance = (sum / (@ic.all.size.to_f - 1))
  end
end
