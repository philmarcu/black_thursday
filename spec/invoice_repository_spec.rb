require './lib/invoice'
require './lib/invoice_repository'


RSpec.describe InvoiceRepository do
  before :each do
    @inv_c = InvoiceRepository.new("./data/invoices.csv")
  end

  it 'exists & has attributes' do
    expect(@inv_c).to be_a(InvoiceRepository)
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

  it 'can find all by merchant id' do
    expect(@inv_c.find_all_by_merchant_id("12336617").length).to eq(11)
    expect(@inv_c.find_all_by_merchant_id("12334839").length).to eq(9)
  end

  it 'can find all by status' do
    expect(@inv_c.find_all_by_status("shipped").length).to eq(2839)
    expect(@inv_c.find_all_by_status("returned").length).to eq(673)
  end
### needs looking into
  it 'can create attributes' do
    attributes = {
                  customer_id: 1000,
                  id: 4986,
                  merchant_id: 12445541,
                  status: "pending"
                }
    expect(@inv_c.all.length).to eq(4985)
    @inv_c.create(attributes)
    expect(@inv_c.all.length).to eq(4986)
    expect(@inv_c.all.last.customer_id).to eq("1001")
    expect(@inv_c.all.last.merchant_id).to eq(12445541)
  end

  it 'can update attributes' do

    attributes = {
                  status: "returned",
                  updated_at: Time.now.to_s
                }

    expect(@inv_c.find_by_id("4985").customer_id).to eq("999")
    @inv_c.update("4985", attributes)
    expect(@inv_c.find_by_id("4985").status).to eq("returned")
  end

  it 'can delete attributes' do
    attributes = {
                  id: 4896,
                  customer_id: 1000,
                  merchant_id: 12445541,
                  status: "shipped",
                  updated_at: Time.now.to_s
                }
    @inv_c.create(attributes)
    expect(@inv_c.find_by_id("4896")).to be_a(Invoice)
    expect(@inv_c.all.length).to eq(4986)
    @inv_c.delete("4896")
    expect(@inv_c.find_by_id("4896")).to eq(nil)
    expect(@inv_c.all.length).to eq(4985)
  end

  it 'can group by merchant ids' do
    expect(@inv_c.group_by_merchant_id).to be_a(Hash)
    expect(@inv_c.group_by_merchant_id["12334185"].count).to eq(10)
    expect(@inv_c.group_by_merchant_id["12334185"].first.id).to eq("1495")
  end
end
