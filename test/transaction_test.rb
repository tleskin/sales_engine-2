require_relative 'test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test

  attr_reader :transaction

  def sample_data
    {
      id: "1",
      invoice_id: "1" ,
      credit_card_number: "4654405418249632",
      credit_card_expiration_date: "",
      result: "success",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC"
    }
  end

  def setup
    @transaction = Transaction.new(sample_data, sales_engine=nil)
  end

  def test_it_exists
    assert Transaction
  end

  def test_it_has_an_id
    assert_equal 1, transaction.id
  end

  def test_it_has_an_invoice_id
    assert_equal 1, transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    assert_equal "", transaction.credit_card_expiration_date
  end

  def test_it_has_a_created_date
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
  end

  def test_it_has_an_updated_date
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end
end
