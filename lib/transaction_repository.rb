require_relative 'load_file'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @transactions = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @transactions = file.map do |row|
      Transaction.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  ## Find by methods

  def find_by_id(id)
    transactions.detect {|transaction|transaction.id == id}
  end

  def find_by_invoice_id(invoice_id)
    transactions.detect {|transaction|transaction.invoice_id == invoice_id}
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.detect {|credit_card| credit_card.credit_card_number == credit_card_number}
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.detect {|credit_card| credit_card.credit_card_expiration_date == credit_card_expiration_date}
  end

  def find_by_result(result)
    transactions.detect {|transaction|transaction.result == result}
  end

  def find_by_created_at(created_at)
    transactions.detect {|transaction|transaction.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    transactions.detect {|transaction|transaction.updated_at == updated_at}
  end

  ## Find all by methods

  def find_all_by_id(id)
    transactions.select {|transaction|transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select {|transaction|transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select {|transaction|transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_credit_card_expiration_date(ex_date)
    transactions.select {|transaction|transaction.ex_date == ex_date}
  end

  def find_all_by_result(result)
    transactions.select {|transaction|transaction.result == result}
  end

  def find_all_by_created_at(created_at)
    transactions.select {|transaction|transaction.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    transactions.select {|transaction|transaction.updated_at == updated_at}
  end

  ## Other methods

  def find_invoice(id)
  sales_engine.find_invoice_by_id(id)
end

  def all_successful
  transactions.select do |transaction|
    transaction.result == "success"
  end
end

end
