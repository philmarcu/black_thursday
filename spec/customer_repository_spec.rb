require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  before :each do
    @c = CustomerRepository.new("./data/customers.csv")
  end

  it 'exists & has attributes' do
    expect(@c).to be_a(CustomerRepository)
    expect(@c.all).to be_a(Array)
    expect(@c.all.length).to eq(475)
  end

  it 'returns data from our customer array' do
    expect(@c.all.first.id).to eq("12334105")
    expect(@c.all.first).to be_a(Customer)
    expect(@c.all.last.name).to eq("CJsDecor")
  end

  it 'can find a customer by id' do
    expect(@c.find_by_id("12334672")).to be_a(Customer)
    expect(@c.find_by_id("11").first_name).to eq("Logan")
    expect(@c.find_by_id("11").last_name).to eq("Kris")
  end

  it 'can find a customer by name' do
    expect(@c.find_by_name("JacquieMann")).to be_a(Customer)
    expect(@c.find_by_name("JacquieMann").id).to eq("12334189")
  end

  it 'can find all names given the characters' do
    expect(@c.find_all_by_name("ing").length).to eq(24)
    expect(@c.find_all_by_name("iNg").length).to eq(24)
    expect(@c.find_all_by_name("store").length).to eq(4)
    expect(@c.find_all_by_name("sToRe").length).to eq(4)
    expect(@c.find_all_by_name("uNIFoRd").length).to eq(1)
    expect(@c.find_all_by_name("uniford").first.id).to eq("12334174")
  end

  it 'can create attributes' do
    attributes = {
                  id: 12337412,
                  name: "WingzandThingz"
                }
    expect(@c.all.length).to eq(475)
    @c.create(attributes)
    expect(@c.all.length).to eq(476)
    expect(@c.all.last.name).to eq("WingzandThingz")
  end

  it 'can update attributes' do
    attributes = {
                  name: "Random212",
                  updated_at: Time.now.to_s
                }

    expect(@c.find_by_id("12337209").name).to eq("bizuteriaNYC")
    @c.update("12337209", attributes)
    expect(@c.find_by_id("12337209").name).to eq("Random212")
  end

  it 'can delete attributes' do
    attributes = {
                  id: 12337412,
                  name: "WingzandThingz"
                }
    @c.create(attributes)
    expect(@c.find_by_id("12337412")).to be_a(Customer)
    expect(@c.all.length).to eq(476)
    @c.delete("12337412")
    expect(@c.find_by_id("12337412")).to eq(nil)
    expect(@c.all.length).to eq(475)
  end
end
