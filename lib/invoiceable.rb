module Invoiceable
  def merc_invoice_count
    invoices_per = @inv_c.group_by_merchant_id
    invoices_per.map {|merchant, invoice| invoice.count}
  end

  def square_sum_of_total_invoices
    mean = average_invoices_per_merchant
    invoice_arr = merc_invoice_count.map {|invoice| (invoice - mean) ** 2}
    invoice_arr.sum
  end

  def invoice_variance
    sum = square_sum_of_total_invoices
    merc_total = @mc.all.size
    (sum / (merc_total.to_f - 1))
  end

  def two_std_dev_above_inv_std_dev
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    (mean + (std_dev * 2)).round(2)
  end

  def two_std_dev_below_inv_std_dev
    mean = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    (mean - (std_dev * 2))
  end

  def merc_inv_hash
    mc_inv_hash = {}
    @inv_c.all.each do |invoice|
      @mc.all.each do |merchant|
        if invoice.merchant_id == merchant.id
          mc_inv_hash[merchant] ||= 0
          mc_inv_hash[merchant] += 1
        end
      end
    end
    mc_inv_hash
  end
end
