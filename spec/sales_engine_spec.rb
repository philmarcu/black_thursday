require "./lib/sales_engine"
require "./lib/item_collection"
require "./lib/merchant_collection"
require "./lib/sales_analyst"
require './lib/invoice_collection'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
  end

  it "exists" do
    expect(@se).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    expect(@se.item_collection).to be_instance_of ItemCollection
  end

  it "can return an array of all instances" do
    expect(@se.merchant_collection).to be_instance_of MerchantCollection
  end

  it 'can return child instances' do
    ic = @se.item_collection
    item = ic.find_by_name("Thukdokhin wax cord")

    expect(ic).to be_a(ItemCollection)
    expect(item.id).to eq("263404585")
  end

  it 'can have a sales_analyst' do
    sa = @se.analyst
    expect(sa).to be_a(Analyst)
    expect(sa.average_items_per_merchant).to eq(2.88)
  end

  it 'can return an array of invoices' do
    inv_c = @se.invoices
  end
end
