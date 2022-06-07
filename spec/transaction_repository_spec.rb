require './lib/transaction'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before :each do
    @t_repo= TransactionRepository.new("./data/transactions.csv")
  end

  it 'exists & has attributes' do
    expect(@t_repo).to be_a(TransactionRepository)
    expect(@t_repo.all).to be_a(Array)
    expect(@t_repo.all.length).to eq(4985)
  end

  it 'returns data from our transaction array' do
    expect(@t_repo.all.first.id).to eq("1")
    expect(@t_repo.all.first).to be_a(Transaction)
    expect(@t_repo.all.first.invoice_id).to eq("2179")
  end

  it 'can find an transaction by id' do
    expect(@t_repo.find_by_id("22")).to be_a(Transaction)
    expect(@t_repo.find_by_id("30").invoice_id).to eq("1840")
    expect(@t_repo.find_by_id("35").credit_card_number).to eq("4018861240397577")
  end

  it 'can find all by invoice id' do
    expect(@t_repo.find_all_by_invoice_id("2639").length).to eq(4)
    expect(@t_repo.find_all_by_invoice_id("419").length).to eq(1)
  end

  it 'can find all by credit card number' do
    expect(@t_repo.find_all_by_credit_card_number("4917644581850456").length).to eq(1)
    expect(@t_repo.find_all_by_credit_card_number("4177816490204479").length).to eq(1)
  end

  it 'can find all by result' do
    expect(@t_repo.find_all_by_result("failed").length).to eq(827)
  end

  it 'can create attributes' do
    attributes = {
                  id: 4986,
                  invoice_id: 5000,
                  credit_card_number: 5177816490204479,
                  credit_card_expiration_date: 0524,
                  result: "success"
                }
    expect(@t_repo.all.last.id).to eq("4985")
    @t_repo.create(attributes)
    expect(@t_repo.all.last.id).to eq("4986")
    expect(@t_repo.all.last.invoice_id).to eq(5000)
    expect(@t_repo.all.last.result).to eq("success")
  end

  it 'can update attributes' do

    attributes = {
                  credit_card_number: 5177816490204479,
                  credit_card_expiration_date: 0524,
                  result: "failed",
                  updated_at: Time.now.to_s
                }

    expect(@t_repo.find_by_id("5").invoice_id).to eq("3715")
    @t_repo.update("5", attributes)
    expect(@t_repo.find_by_id("5").credit_card_number).to eq(5177816490204479)
    expect(@t_repo.find_by_id("5").result).to eq("failed")
  end

  it 'can delete attributes' do
    attributes = {
                  id: 4986,
                  invoice_id: 5000,
                  credit_card_number: 5177816490204479,
                  credit_card_expiration_date: 0524,
                  result: "success"
                }
    @t_repo.create(attributes)
    expect(@t_repo.find_by_id("4986")).to be_a(Transaction)
    @t_repo.delete("4986")
    expect(@t_repo.find_by_id("4986")).to eq(nil)
    end
end
