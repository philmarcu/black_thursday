require './lib/merchant'
require './lib/item'
require 'bigdecimal'

RSpec.describe Item do
  it 'initialize item' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    expect(i).to be_instance_of Item
  end

  it 'return price of item in dollars' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    expect(i.unit_price_to_dollars).to eq(10.99)
  end

  it 'can update info' do
    @i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
      })
    attributes = { name: "Pen", description: "Writes with ink", unit_price: BigDecimal(20.99,4), :updated_at  => Time.now }
    expect(@i.id).to eq(1)
    @i.update_info(attributes)
    expect(@i.name).to eq("Pen")
    expect(@i.description).to eq("Writes with ink")
    expect(@i.unit_price).to eq(BigDecimal(20.99,4))
  end

end
