require 'CSV'
require_relative "transaction"

class TransactionRepository
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(:id => row[:id], :invoice_id => row[:invoice_id], :credit_card_number => row[:credit_card_number], :credit_card_expiration_date => row[:credit_card_expiration_date], :result => row[:result], :created_at => row[:created_at], :updated_at => row[:updated_at])
    end
  end

  def find_by_id(id)
    @all.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    @all.find_all {|transaction| transaction.result== result}
  end

  def create(attributes)
    attributes[:id] = (@all.last.id.to_i + 1).to_s
    invoice_id = attributes[:invoice_id]
    credit_card_number = attributes[:credit_card_number]
    credit_card_expiration_date = attributes[:credit_card_expiration_date]
    result = attributes[:result]
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Transaction.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)
    updated = self.find_by_id(id)
    updated.update_info(attributes)
  end

  def delete(id)
    @all.delete_if do |transaction|
      transaction.id == id
    end
  end

end
