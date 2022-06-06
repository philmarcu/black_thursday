require 'CSV'
require_relative "item"
class ItemRepository

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id])
      end
  end

  def find_by_id(id)
    @all.find {|item| item.id == id}
  end

  def find_by_name(name)
    @all.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description)
    @all.find_all {|item| item.description.upcase.include?(description.upcase)}
  end

  def find_all_by_price(price)
    @all.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
    (range.min..range.max).cover?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(attributes)
    max_id = @all.max_by {|item| item.id}
    attributes[:id] = (max_id.id.to_i + 1).to_s
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Item.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)
    updated = self.find_by_id(id)
    updated.update_info(attributes)
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

  def group_by_merchant_id
    @all.group_by {|value| value.merchant_id}
  end
end
