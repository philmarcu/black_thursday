require "./lib/sales_engine"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
            :items => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv",
            :transactions => ("./data/transactions.csv"),
            :customers => ("./data/customers.csv")
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
end
