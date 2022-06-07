require 'CSV'
require_relative 'customer'
class CustomerRepository

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(:id => row[:id], :first_name => row[:first_name], :last_name => row[:last_name])
    end
  end

  def find_by_id(id)
    @all.find {|customer| customer.id == id}
  end

  def find_by_name(name)
    @all.find {|customer| customer.first_name == name}
    @all.find {|customer| customer.last_name == name}
  end

  def find_all_by_name(name)
    @all.find_all {|customer| customer.name.upcase.include?(name.upcase)}
  end

  def create(attributes)
    max_id = @all.max_by {|customer| customer.id}
    attributes[:id] = (max_id.id.to_i + 1).to_s
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Customer.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)
    updated = self.find_by_id(id)
    updated.update_info(attributes)
  end

  def delete(id)
    @all.delete_if do |customer|
      customer.id == id
    end
  end
end
