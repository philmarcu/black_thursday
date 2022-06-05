require './lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  it 'initialize invoice item' do
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
    expect(@ii).to be_instance_of InvoiceItem
  end

  it 'return price of invoice item in dollars' do
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end

  it 'can update info' do
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
    attributes = { quantity:  2, unit_price: BigDecimal(20.99,4), updated_at: Time.now }
    expect(@ii.id).to eq(6)
    @ii.update_info(attributes)
    expect(@ii.quantity).to eq(2)
    expect(@ii.unit_price).to eq(BigDecimal(20.99,4))
  end


end
