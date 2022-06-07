require './lib/customer'
require './lib/sales_engine'

RSpec.describe Customer do
  before :each do
    @c = Customer.new({id: 5, :first_name => "Lois", :last_name => "Clark"})
  end

  it 'exists' do
    expect(@c).to be_a(Customer)
  end

  it 'has attributes' do
    expect(@c.id).to eq(5)
    expect(@c.first_name).to eq("Lois")
    expect(@c.last_name).to eq("Clark")
  end

  it 'can create attributes' do
    expect(@c.created_at).to eq(Time.now.to_s)
    expect(@c.updated_at).to eq(Time.now.to_s)
  end

  it 'can update info' do
    attributes = {first_name: "Lois"}
    expect(@c.id).to eq(5)
    @c.update_info(attributes)
    expect(@c.first_name).to eq("Lois")
    expect(@c.last_name).to eq("Clark")
  end
end
