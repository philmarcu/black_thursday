require './lib/transaction'

RSpec.describe Transaction do
  it 'initialize transaction' do
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    expect(@t).to be_instance_of Transaction
  end

  it 'can update info' do
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    attributes = { credit_card_number:  "9898989898989898", credit_card_expiration_date: "0824", result: "failed", updated_at: Time.now }
    expect(@t.id).to eq(6)
    @t.update_info(attributes)
    expect(@t.credit_card_number).to eq("9898989898989898")
    expect(@t.credit_card_expiration_date).to eq("0824")
  end


end
