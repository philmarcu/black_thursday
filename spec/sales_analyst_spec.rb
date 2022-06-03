require "./lib/sales_engine"
require "./lib/item_collection"
require "./lib/merchant_collection"
require "./lib/sales_analyst"

RSpec.describe Analyst do
 it 'exist' do
   sales_analyst = Analyst.new("./data/items.csv", "./data/merchants.csv")
   expect(sales_analyst).to be_a(Analyst)
 end

 it 'calculates average items per merchant' do
   sales_analyst = Analyst.new("./data/items.csv", "./data/merchants.csv")
   expect(sales_analyst.average_items_per_merchant).to eq(2.88)
 end

end
