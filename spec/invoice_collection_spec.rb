require './lib/invoice'
require './lib/invoice_collection'

RSpec.describe InvoiceCollection do
  before :each do
    @inv_c = InvoiceCollection.new("./data/invoices.csv")
  end

  it 'exists & has attributes' do
    expect(@inv_c).to be_a(InvoiceCollection)
    expect(@inv_c.all).to be_a(Array)
    expect(@inv_c.all.length).to eq(4985)
  end

  it 'returns data from our invoice array' do
    expect(@inv_c.all.first.id).to eq("1")
    expect(@inv_c.all.first).to be_a(Invoice)
    expect(@inv_c.all.last.merchant_id).to eq("12335541")
  end

  it 'can find an invoice by id' do
    expect(@inv_c.find_by_id("12")).to be_a(Invoice)
    expect(@inv_c.find_by_id("659").merchant_id).to eq("12334684")
    expect(@inv_c.find_by_id("270").customer_id).to eq("51")
  end
  #
  it 'can find all by customer id' do
    expect(@inv_c.find_all_by_customer_id("1").length).to eq(8)
    expect(@inv_c.find_all_by_customer_id("81").length).to eq(6)
  end
  #
  # it 'can find all names given the characters' do
  #   expect(@mc.find_all_by_name("ing").length).to eq(24)
  #   expect(@mc.find_all_by_name("iNg").length).to eq(24)
  #   expect(@mc.find_all_by_name("store").length).to eq(4)
  #   expect(@mc.find_all_by_name("sToRe").length).to eq(4)
  #   expect(@mc.find_all_by_name("uNIFoRd").length).to eq(1)
  #   expect(@mc.find_all_by_name("uniford").first.id).to eq("12334174")
  # end
  #
  # it 'can create attributes' do
  #   attributes = {
  #                 id: 12337412,
  #                 name: "WingzandThingz"
  #               }
  #   expect(@mc.all.length).to eq(475)
  #   @mc.create(attributes)
  #   expect(@mc.all.length).to eq(476)
  #   expect(@mc.all.last.name).to eq("WingzandThingz")
  # end
  #
  # it 'can update attributes' do
  #   attributes = {
  #                 name: "Random212",
  #                 updated_at: Time.now.to_s
  #               }
  #
  #   expect(@mc.find_by_id("12337209").name).to eq("bizuteriaNYC")
  #   @mc.update("12337209", attributes)
  #   expect(@mc.find_by_id("12337209").name).to eq("Random212")
  # end
  #
  # it 'can delete attributes' do
  #   attributes = {
  #                 id: 12337412,
  #                 name: "WingzandThingz"
  #               }
  #   @mc.create(attributes)
  #   expect(@mc.find_by_id("12337412")).to be_a(Merchant)
  #   expect(@mc.all.length).to eq(476)
  #   @mc.delete("12337412")
  #   expect(@mc.find_by_id("12337412")).to eq(nil)
  #   expect(@mc.all.length).to eq(475)
  # end
end
