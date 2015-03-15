require_relative 'test_helper'
require '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader :transaction_repository

  def test_it_exitsts
    assert TransactionRepository
  end

  def setup
    @transaction_repository = TransactionRepository.load('./data/transactions.csv')
  end

  def test_that_transaction_repo_containts_transaction_data
    assert_equal 5596, transaction_repository.transactions.count
  end

  def test_that_transaction_repo_is_not_empty
    refute transaction_repository.transactions.empty?
  end

  def test_it_returns_all_transaction_records
    transaction_repo = TransactionRepository.load('./data/transactions.csv')
    assert_equal 5596, transaction_repository.all.count
  end

  def test_it_grabs_a_random_transaction
    transaction = @transaction_repository.random
    assert_equal Transaction, transaction.class
  end

  def test_it_finds_a_transaction_by_id
    results = transaction_repository.find_by_id(1)
    assert_equal 1, results.id
  end

  def test_it_finds_a_transaction_by_name
    results = transaction_repository.find_by_name("Insert Transaction CSV Data here")
    assert_equal "Transasction CSV Data", results.name
  end

  def test_it_finds_a_transaction_by_created_at
    results = transaction_repository.find_by_created_at("Insert Transaction CSV Data here")
    assert_equal "TransactionCSV DATA here", results.created_at
  end

  def test_it_finds_a_transaction_by_updated_at
    results = transaction_repository.find_by_updated_at("Insert TransactionCSV data here")
    assert_equal "TransactionCSV Data here", results.updated_at
  end

  def test_it_finds_all_by_name
    results = transaction_repository.find_all_by_name("Transaction Data here")
    assert_equal 2, results.count
  end

  def test_it_finds_all_by_created_at
    results = transaction_repository.find_all_by_created_at("Transactions CSV data")
    assert_equal 9, results.count
  end

  def test_it_finds_all_by_created_at
    results = transaction_repository.find_all_by_updated_at("Transaction CSV data")
    assert_equal 8, results.count
  end
end