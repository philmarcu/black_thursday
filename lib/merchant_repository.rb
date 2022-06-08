require 'CSV'
require_relative 'merchant'
require_relative 'findable'
class MerchantRepository
  include Findable

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(:id => row[:id], :name => row[:name], :created_at => row[:created_at])
    end
  end

  def create(attributes)
    max_id = @all.max_by {|merchant| merchant.id}
    attributes[:id] = (max_id.id.to_i + 1).to_s
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Merchant.new(attributes)
    @all.push(new)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
