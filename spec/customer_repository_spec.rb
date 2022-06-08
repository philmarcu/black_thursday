require './lib/customer'
require './lib/customer_repository'

RSpec.describe CustomerRepository do
  before :each do
    @c = CustomerRepository.new("./data/customers.csv")
  end

  it 'exists & has attributes' do
    expect(@c).to be_a(CustomerRepository)
    expect(@c.all).to be_a(Array)
    expect(@c.all.length).to eq(1000)
  end

  it 'returns data from our transaction array' do
    expect(@c.all.first.id).to eq("1")
    expect(@c.all.first).to be_a(Customer)
    expect(@c.all.first.last_name).to eq("Ondricka")
  end

  it 'can find an customer by id' do
    expect(@c.find_by_id("8")).to be_a(Customer)
    expect(@c.find_by_id("12").first_name).to eq("Ilene")
    expect(@c.find_by_id("17").last_name).to eq("Baumbach")
  end

  it 'can find all by first_name' do
    expect(@c.find_all_first_name("Sophia").length).to eq(1)
    expect(@c.find_all_first_name("Sasha").length).to eq(2)
  end

  it 'can find all by last_name' do
    expect(@c.find_all_last_name("King").length).to eq(5)
    expect(@c.find_all_last_name("Brown").length).to eq(2)
  end

  it 'can create attributes' do
    attributes = {
                  id: 1000,
                  first_name: "Maria",
                  last_name: "Smith",
                }
    expect(@c.all.last.id).to eq("1000")
    @c.create(attributes)
    expect(@c.all.last.id).to eq("1001")
    expect(@c.all.last.first_name).to eq("Maria")
    expect(@c.all.last.last_name).to eq("Smith")
  end

  it 'can update attributes' do

    attributes = {
                  id: 10,
                  first_name: "Rick",
                  last_name: "Ronna",
                }

    expect(@c.find_by_id("10").last_name).to eq("Reynolds")
    @c.update("10", attributes)
    expect(@c.find_by_id("10").last_name).to eq("Ronna")
  end

  it 'can delete attributes' do
    attributes = {
                  id: 1000,
                  first_name: "Maria",
                  last_name: "Smith",
                }
    @c.create(attributes)
    expect(@c.find_by_id("1001")).to be_a(Customer)
    @c.delete("1001")
    expect(@c.find_by_id("1001")).to eq(nil)
    end
end
