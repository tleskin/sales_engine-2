require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions


  def initialize(transactions, sales_engine)
    @transactions = transactions
    @sales_engine = sales_engine
  end

  def self.load(sales_engine, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Transaction.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def all
    @transactions
  end

  def random
    @transactions.sample
  end

  def find_by_id(id)
    @transactions.detect {|transaction|transaction.id == id}
  end

  def find_by_invoice_id(invoice_id)
    @transactions.detect {|transaction|transaction.invoice_id == invoice_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.select {|transaction|transaction.invoice_id == invoice_id}
  end

  def find_by_credit_card_number(credit_card_number)
    @transactions.detect {|credit_card|credit_card.credit_card_number == credit_card_number}
  end

  def find_by_created_at(created_at)
    @transactions.detect {|transaction|transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @transactions.detect {|transaction|transaction.updated_at == updated_at}
  end

  def find_all_by_created_at(created_at)
    @transactions.select {|transaction|transaction.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @transactions.select {|transaction|transaction.updated_at == updated_at}
  end

  def find_all_by_result(result)
    @transactions.select {|transaction|transaction.result == result}
  end
end
