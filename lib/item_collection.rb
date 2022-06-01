require 'CSV'
class ItemCollection

  def initialize(file_path)
    @file_path = file_path
  end

  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    @all << Item.new(:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]
  end

end
