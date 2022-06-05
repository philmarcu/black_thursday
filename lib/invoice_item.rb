class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @quantity = value if key == :quantity
      @unit_price = value if key == :unit_price
      @updated_at = value if key == :updated_at
    end
  end

end
