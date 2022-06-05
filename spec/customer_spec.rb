require './lib/customer'

RSpec.describe Customer do
  it 'initialize transaction' do
    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    expect(@c).to be_instance_of Customer
  end

  it 'can update info' do
    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    attributes = { first_name:  "Gabbie", last_name: "Steward", updated_at: Time.now }
    expect(@c.id).to eq(6)
    @c.update_info(attributes)
    expect(@c.first_name).to eq("Gabbie")
    expect(@c.last_name).to eq("Steward")
  end


end
