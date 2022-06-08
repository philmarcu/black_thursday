class Merchant

  attr_reader :id, :name, :created_at
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @name = value if key == :name
    end
  end
end
