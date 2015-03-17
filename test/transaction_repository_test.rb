require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repository

  def test_it_exists
    assert TransactionRepository
  end

  def setup
    @transaction_repository = TransactionRepository.load(self, './test/test_fixtures/transactions_sample.csv')
  end

  def test_that_transaction_repo_contains_data
    assert_equal 20, @transaction_repository.transactions.count
  end

  def test_transaction_repository_is_not_empty
    refute @transaction_repository.transactions.empty?
  end

  def test_it_returns_all_transaction_items
    assert_equal 20, transaction_repository.all.count
  end

  def test_it_grabs_a_random_transaction

    transaction = @transaction_repository.random
    assert_equal Transaction, transaction.class
  end

  def test_it_finds_transaction_by_invoice_id
    results = @transaction_repository.find_by_invoice_id(1)
    assert_equal 1, results.invoice_id
  end

  def test_it_finds_transaction_by_credit_card_number
    results = @transaction_repository.find_by_credit_card_number("4654405418249632")
    assert_equal "4654405418249632", results.credit_card_number
  end

  def test_it_finds_a_transaction_by_created_at
    results = @transaction_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", results.created_at
  end

  def test_it_finds_a_transaction_by_updated_at
    results = @transaction_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", results.updated_at
  end

  def test_it_finds_all_created_at
    results = @transaction_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, results.count
  end

  def test_it_finds_all_updated_at
    results = @transaction_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, results.count
  end

  def test_it_finds_all_by_result
    results = @transaction_repository.find_all_by_result("success")
    assert_equal 16, results.count
  end
end
