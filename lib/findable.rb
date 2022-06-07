module Findable
  def find_by_id(id)
    @all.find {|value| value.id == id}
  end

  def find_by_name(name)
    @all.find {|value| value.name == name}
  end

  def find_all_by_name(name)
    @all.find_all {|value| value.name.upcase.include?(name.upcase)}
  end

  def find_all_with_description(description)
    @all.find_all {|value| value.description.upcase.include?(description.upcase)}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|value| value.merchant_id == merchant_id}
  end

  def group_by_merchant_id
    @all.group_by {|value| value.merchant_id}
  end

  def update(id, attributes)
    updated = self.find_by_id(id)
    updated.update_info(attributes)
  end

  def delete(id)
    @all.delete_if do |value|
      value.id == id
    end
  end
end
