module Dayable

  def day_name_array
    days_arr = @inv_c.all.map {|invoice| DateTime.parse(invoice.created_at)}
    days_arr.map {|day| day.strftime('%A')}
  end

  def total_invoices_made_by_day
    days_arr = day_name_array
    array = []
    sunday = days_arr.count("Sunday")
    monday = days_arr.count("Monday")
    tuesday = days_arr.count("Tuesday")
    wednesday = days_arr.count("Wednesday")
    thursday = days_arr.count("Thursday")
    friday = days_arr.count("Friday")
    saturday = days_arr.count("Saturday")
    array << [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
    week = array.flatten
  end

  def avg_invoices_by_day
    week = total_invoices_made_by_day
    ( week.sum / 7 )
  end

  def square_sum_of_total_day_invs
    week = total_invoices_made_by_day
    mean = avg_invoices_by_day
    inv_total = @inv_c.all.length
    inv_day_arr = week.map {|day| (day - mean) ** 2}
    inv_day_arr.sum
  end

  def invoice_day_variance
    sum_inv = square_sum_of_total_day_invs
    (sum_inv / 6)
  end

  def std_dev_of_invoices_by_day
    variance = invoice_day_variance
    Math.sqrt(variance).round(2)
  end

  def one_std_dev_above_mean
    mean = avg_invoices_by_day
    std_dev = std_dev_of_invoices_by_day
    (mean + std_dev)
  end

  def dayname_count_hash
    uniq_days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Fiday', 'Saturday']
    days_arr = total_invoices_made_by_day
    uniq_days.each do |day|
      days_arr.each do |total|
        return Hash[uniq_days.zip(days_arr)]
      end
    end
  end
end
