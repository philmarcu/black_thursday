require 'CSV'
require_relative "customer"
require_relative "findable"

class CustomerRepository
  include Findable
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(:id => row[:id], :first_name => row[:first_name], :last_name=> row[:last_name], :created_at => row[:created_at], :updated_at => row[:updated_at])
    end
  end

  def find_all_first_name(first_name)
    @all.find_all {|customer| customer.first_name == first_name}
  end

  def find_all_last_name(last_name)
    @all.find_all {|customer| customer.last_name == last_name}
  end

  def create(attributes)
    attributes[:id] = (@all.last.id.to_i + 1).to_s
    first_name = attributes[:first_name]
    last_name = attributes[:last_name]
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Customer.new(attributes)
    @all.push(new)
  end
end
