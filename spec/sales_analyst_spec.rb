require "./lib/sales_engine"
require "./lib/sales_analyst"

RSpec.describe Analyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
            :items => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => "./data/invoices.csv"
          })
    @sales_analyst = @sales_engine.analyst
  end

 it 'exist' do
   expect(@sales_analyst).to be_a(Analyst)
 end

 it 'calculates average items per merchant' do
   expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
 end

 it 'can give total items per merchant' do
   expect(@sales_analyst.total_items_per_merchant).to be_a(Array)
   expect(@sales_analyst.total_items_per_merchant[3]).to eq(20)
 end

 it 'gets the square_diffs_of_total_items' do
   expect(@sales_analyst.square_diffs_of_total_items).to be_a(Array)
   expect(@sales_analyst.square_diffs_of_total_items.first.round(2)).to eq(3.53)
   expect(@sales_analyst.square_diffs_of_total_items[8].round(2)).to eq(4.49)
 end

 it 'gets the sum_of_total_item_nums' do
   expect(@sales_analyst.sum_of_total_item_nums.round(2)).to eq(5034.92)
 end

 it 'returns the variance_of_items' do
   expect(@sales_analyst.variance_of_items.round(2)).to eq(10.62)
 end

 it 'can return the average items by standard deviation' do
   expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
 end

 it 'can return one standard deviation above the merchant std dev' do
   expect(@sales_analyst.one_std_dev_above_merchant_std_dev).to eq(6.14)
 end

 it 'can return merchants with high item count' do
   expect(@sales_analyst.merchants_with_high_item_count.size).to eq(52)
   expect(@sales_analyst.merchants_with_high_item_count.first.name).to eq("Keckenbauer")
   expect(@sales_analyst.merchants_with_high_item_count.last.id).to eq("12336965")
 end

 it 'returns the item_count_for_merchant' do
   expect(@sales_analyst.item_count_for_merchant("12336965")).to eq(10)
 end

 it 'returns the average item price for merchant' do
   expect(@sales_analyst.average_item_price_for_merchant("12336965")).to eq(59910)
   expect(@sales_analyst.average_item_price_for_merchant("12334159")).to eq(3150)
   expect(@sales_analyst.average_item_price_for_merchant("12334159").class).to be(BigDecimal)
 end
end
