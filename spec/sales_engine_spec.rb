require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/sales_analyst"
require './lib/invoice_repository'
require './lib/transaction_repository'
require './lib/customer_repository'

RSpec.describe SalesEngine do
  before :each do
    @se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv",
        :transactions => ("./data/transactions.csv"),
        :customers => ("./data/customers.csv")
      })
      @ic = @se.item_repository
      @mc = @se.merchant_repository
      @inv_c = @se.invoice_repository
      @t_repo = @se.transaction_repository
      @c = @se.customer_repository
      @sa = @se.analyst
  end

  it "exists" do
    expect(@se).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    expect(@ic).to be_instance_of ItemRepository
  end

  it "can return an array of all instances" do
    expect(@mc).to be_instance_of MerchantRepository
  end

  it 'can return child instances' do
    item = @ic.find_by_name("Thukdokhin wax cord")

    expect(item.id).to eq("263404585")
  end

  it 'can have a sales_analyst' do
    expect(@sa).to be_a(SalesAnalyst)
    expect(@sa.average_items_per_merchant).to eq(2.88)
  end

  it 'can return an array of invoices' do
    expect(@inv_c).to be_a(InvoiceRepository)
  end
end
