require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  before :each do
    @inv_ic = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  it 'exists & has attributes' do
    expect(@inv_ic).to be_a(InvoiceItemRepository)
    expect(@inv_ic.all).to be_a(Array)
  end

  it 'returns data from our invoice item array' do
    expect(@inv_ic.all.first.id).to eq("1")
    expect(@inv_ic.all.first).to be_a(InvoiceItem)
    expect(@inv_ic.all[1].item_id).to eq("263454779")
  end

  it 'can find an invoice item by id' do
    expect(@inv_ic.find_by_id("42")).to be_a(InvoiceItem)
    expect(@inv_ic.find_by_id("491").item_id).to eq("263410671")
    expect(@inv_ic.find_by_id("140").quantity).to eq("1")
  end

  it 'can find all by item id' do
    expect(@inv_ic.find_all_by_item_id("263401817").length).to eq(23)
    expect(@inv_ic.find_all_by_item_id("263399953").length).to eq(20)
  end

  it 'can find all by invoice id' do
    expect(@inv_ic.find_all_by_invoice_id("484").length).to eq(8)
    expect(@inv_ic.find_all_by_invoice_id("2184").length).to eq(4)
  end

  it 'can create attributes' do
    attributes = {
                  invoice_id: 4986,
                  item_id: 263519845,
                  id: 21831,
                  quantity: 12
                }
    expect(@inv_ic.all.last.id).to eq("21830")
    @inv_ic.create(attributes)
    expect(@inv_ic.all.last.id).to eq("21831")
    expect(@inv_ic.all.last.item_id).to eq("263519845")
  end

  it 'can update attributes' do

    attributes = {
                  quantity: 1542,
                  unit_price: 30000,
                  updated_at: Time.now.to_s
                }

    expect(@inv_ic.find_by_id("10").item_id).to eq("263523644")
    @inv_ic.update("10", attributes)
    expect(@inv_ic.find_by_id("10").quantity).to eq(1542)
    expect(@inv_ic.find_by_id("10").unit_price).to eq(30000)
  end

  it 'can delete attributes' do
    attributes = {
                  invoice_id: 4986,
                  item_id: 263519845,
                  id: 21831,
                  quantity: 12
                }
    @inv_ic.create(attributes)
    expect(@inv_ic.find_by_id("21831")).to be_a(InvoiceItem)
    @inv_ic.delete("21831")
    expect(@inv_ic.find_by_id("21831")).to eq(nil)
    end
end
