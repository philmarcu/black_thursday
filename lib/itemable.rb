module Itemable

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

  def item_merchant_hash
    mc_ic_hash = {}
    @ic.all.each do |item|
      @mc.all.each do |merchant|
        if item.merchant_id == merchant.id
          mc_ic_hash[merchant] ||= 0
          mc_ic_hash[merchant] += 1
        end
      end
    end
    mc_ic_hash
  end
end
