class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(data)
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @first_name = value if key == :first_name
      @last_name = value if key == :last_name
      @updated_at = value if key == :updated_at
    end
  end
end
