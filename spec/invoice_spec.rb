require './lib/invoice'

RSpec.describe Invoice do
  before :each do
    @inv = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
  end

  it 'exists' do
    expect(@inv).to be_a(Invoice)
  end
### time.now changes to quickly to test
  it 'can update invoice info' do
    attributes = { status: "paid", :updated_at  => Time.now }
    @inv.update_info(attributes)
    expect(@inv.status).to eq("paid")
  end

end
