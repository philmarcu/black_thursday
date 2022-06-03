require "./lib/sales_engine"
require "item_collection"
require "merchant_collection"
require "./lib/sales_analyst"

RSpec.describe Analyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
            :items => "./data/items.csv",
            :merchants => "./data/merchants.csv"
          })
    @sales_analyst = @sales_engine.analyst
  end

 it 'exist' do
   expect(@sales_analyst).to be_a(Analyst)
 end

 it 'calculates average items per merchant' do
   expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
 end

 xit 'can return the average items by standard deviation' do
   expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
 end

end
