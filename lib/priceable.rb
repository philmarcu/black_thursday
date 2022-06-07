module Priceable

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
end
