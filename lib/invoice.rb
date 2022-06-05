class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(data)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @status = value if key == :status
      @updated_at = value if key == :updated_at
    end
  end

end
