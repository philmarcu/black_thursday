class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @name = value if key == :name
      @description = value if key == :description
      @unit_price = value if key == :unit_price
    end
  end

end
