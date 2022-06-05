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

end
