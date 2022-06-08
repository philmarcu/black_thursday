require "./lib/sales_engine"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
            :items => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv",
            :transactions => ("./data/transactions.csv"),
            :customers => ("./data/customers.csv"),
            :invoice_items => ("./data/invoice_items.csv")
          })
    @sa = @sales_engine.analyst
  end

 it 'exist' do
   expect(@sa).to be_a(SalesAnalyst)
 end

 it 'calculates average items per merchant' do
   expect(@sa.average_items_per_merchant).to eq(2.88)
 end

 it 'can give total items per merchant' do
   expect(@sa.total_items_per_merchant).to be_a(Array)
   expect(@sa.total_items_per_merchant[3]).to eq(20)
 end

 it 'gets the square_diffs_of_total_items' do
   expect(@sa.square_diffs_of_total_items).to be_a(Array)
   expect(@sa.square_diffs_of_total_items.first.round(2)).to eq(3.53)
   expect(@sa.square_diffs_of_total_items[8].round(2)).to eq(4.49)
 end

 it 'gets the sum_of_total_item_nums' do
   expect(@sa.sum_of_total_item_nums.round(2)).to eq(5034.92)
 end

 it 'returns the variance_of_items' do
   expect(@sa.variance_of_items.round(2)).to eq(10.62)
 end

 it 'can return the average items by standard deviation' do
   expect(@sa.average_items_per_merchant_standard_deviation).to eq(3.26)
 end

 it 'can return one standard deviation above the merchant std dev' do
   expect(@sa.one_std_dev_above_merchant_std_dev).to eq(6.14)
 end

 it 'can return merchants with high item count' do
   expect(@sa.merchants_with_high_item_count.size).to eq(52)
   expect(@sa.merchants_with_high_item_count.first.name).to eq("Keckenbauer")
   expect(@sa.merchants_with_high_item_count.last.id).to eq("12336965")
 end

 it 'returns the item_count_for_merchant' do
   expect(@sa.item_count_for_merchant("12336965")).to eq(10)
 end

 it 'returns the average item price for merchant' do
   expect(@sa.average_item_price_for_merchant("12336965")).to eq(59910)
   expect(@sa.average_item_price_for_merchant("12334159")).to eq(3150)
 end

 it 'can collect the average item prices for all merchants' do
   expect(@sa.collect_average_item_prices).to be_a(Array)
 end

 it 'returns the average average price per merchant' do
   expect(@sa.average_average_price_per_merchant).to eq(35029.4)
 end

 it 'returns the avg price for all merchants' do
   expect(@sa.avg_price_all.round(2)).to eq(25105.51)
 end

 it 'returns the square price diff' do
   expect(@sa.square_price_diffs).to be_a(Array)
 end

 it 'returns the std of prices per item' do
   expect(@sa.std_dev_of_prices_per_item).to eq(290099.0)
 end

 it 'can return the golden_items' do
   expect(@sa.golden_items.length).to eq(5)
   expect(@sa.golden_items.first.name).to eq("Test listing")
   expect(@sa.golden_items.last.id).to eq("263558812")
 end

 it 'returns average_invoices_per_merchant' do
   expect(@sa.average_invoices_per_merchant).to eq(10.49)
 end

 it 'has a merchant_id invoice count hash' do
   first_merc_id_count = @sa.merc_invoice_count.first

   expect(@sa.merc_invoice_count).to be_a(Array)
   expect(first_merc_id_count).to eq(16)
 end

 it 'can get the square & sum of total invoices' do
   expect(@sa.square_sum_of_total_invoices).to eq(5132.7475)
 end

 it 'can get the invoice variance' do
   expect(@sa.invoice_variance.round(2)).to eq(10.83)
 end

 it 'returns average_invoices_per_merchant_standard_deviation' do
   expect(@sa.average_invoices_per_merchant_standard_deviation).to eq(3.29)
 end

 it 'can return a merchant invoice hash' do
   expect(@sa.merc_inv_hash).to be_a(Hash)
 end

 it 'gives us top_merchants_by_invoice_count' do
   expect(@sa.top_merchants_by_invoice_count).to be_a(Array)
   expect(@sa.top_merchants_by_invoice_count.size).to eq(12)
 end

it 'gives us two_std_dev_above_inv_std_dev' do
  expect(@sa.two_std_dev_above_inv_std_dev).to eq(17.07)
end

 it 'gives us two_std_dev_below_inv_std_dev' do
   expect(@sa.two_std_dev_below_inv_std_dev).to eq(3.91)
 end

 it 'gives us bottom_merchants_by_invoice_count' do
   expect(@sa.bottom_merchants_by_invoice_count).to be_a(Array)
   expect(@sa.bottom_merchants_by_invoice_count.size).to eq(4)
 end

 it 'gives us days array of created invoices' do
   expect(@sa.day_name_array).to be_a(Array)
 end

 it 'returns total_invoices_made_by_day' do
   expect(@sa.total_invoices_made_by_day).to be_a(Array)
 end

 it 'returns square_sum_of_total_invoices' do
   expect(@sa.square_sum_of_total_day_invs).to eq(1959)
 end

 it 'returns std_dev_of_invoices_by_day' do
   expect(@sa.std_dev_of_invoices_by_day).to eq(18.06)
 end

 it 'returns one_std_dev_above_mean' do
   expect(@sa.one_std_dev_above_mean).to eq(730.06)
 end

 it 'returns a day name with the invoice count' do
   expect(@sa.dayname_count_hash).to be_a(Hash)
 end

 it 'gives us the top days by invoice count' do
   expect(@sa.top_days_by_invoice_count).to be_a(Array)
   expect(@sa.top_days_by_invoice_count).to eq(["Wednesday"])
 end

 it 'gives the percentage of status' do
   expect(@sa.invoice_status("pending")).to eq(29.55)
   expect( @sa.invoice_status("shipped")).to eq(56.95)
   expect(@sa.invoice_status("returned")).to eq(13.5)
 end

 it 'tells if an invoice is paid successfully or not' do
   expect(@sa.invoice_paid_in_full?("4898")).to eq(true)
   expect(@sa.invoice_paid_in_full?("1485")).to eq(true)
   expect(@sa.invoice_paid_in_full?("628")).to eq(false)
   expect(@sa.invoice_paid_in_full?("4602")).to eq(false)
 end

 it 'gives the total $ amount of the invoice' do
   expect(@sa.invoice_total("2")).to eq(528913)
   expect(@sa.invoice_total("5")).to eq(1582816)
 end

 it 'gives the total revenue by a specific date' do
  expect(@sa.total_revenue_by_date("2004-08-20")).to eq(136350)
  expect(@sa.total_revenue_by_date("2015-09-19")).to eq(54540)
  expect(@sa.total_revenue_by_date("2012-03-27 14:54:09 UTC")).to eq(3340268)
  expect(@sa.total_revenue_by_date("2012-03-27 14:58:08 UTC")).to eq(26734834)
 end

 it 'gets merchants with pending invoices' do
  expect(@sa.merchants_with_pending_invoices).to be_a(Array)
 end

 it 'finds merchants with only one item' do
   expect(@sa.merchants_with_only_one_item.size).to eq(243)
   expect(@sa.merchants_with_only_one_item.first.name).to eq("jejum")
 end

 it 'gives merchants_with_only_one_item_registered_in_month' do
   expect(@sa.merchants_with_only_one_item_registered_in_month("June").size).to eq(18)
   expect(@sa.merchants_with_only_one_item_registered_in_month("February").size).to eq(19)
   expect(@sa.merchants_with_only_one_item_registered_in_month("July")[0].name).to eq("WoodleyShop")
 end

 it 'gives revenue by the merchant' do
   expect(@sa.revenue_by_merchant("12334315")).to eq(490190)
   expect(@sa.revenue_by_merchant("12334403")).to eq(8471300)
 end
end
