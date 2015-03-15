require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :customer_repository

  def test_it_exists
    assert CustomerRepository
  end

  def setup
    @customer_repository = CustomerRepository.load(self, './data/customers_sample.csv')
  end

  def test_that_customer_repo_contains_customer_data
    assert_equal 20, customer_repository.customers.count
  end

  def test_customer_repo_is_not_empty
    refute customer_repository.customers.empty?
  end

  def test_it_returns_all_items_records
    assert_equal 20, customer_repository.all.count
  end

  def test_it_grabs_a_random_item
    customer = @customer_repository.random
    assert_equal Customer, customer.class
  end

  def test_it_finds_a_customer_by_id
     results = customer_repository.find_by_id(1)
     assert_equal 1, results.id
  end

  def test_it_finds_a_customer_by_first_name
     results = customer_repository.find_by_first_name("Joey")
     assert_equal "Joey", results.first_name
  end

  def test_it_finds_a_customer_by_last_name
     results = customer_repository.find_by_last_name("Ondricka")
     assert_equal "Ondricka", results.last_name
  end

  def test_it_finds_an_item_by_created_at
     results = customer_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
     assert_equal "2012-03-27 14:54:09 UTC", results.created_at
  end

  def test_it_finds_an_item_by_updated_at
     results = customer_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
     assert_equal "2012-03-27 14:54:09 UTC", results.updated_at
  end

  def test_it_finds_all_by_first_name
    results = customer_repository.find_all_by_first_name("Joey")
    assert_equal 2, results.count
  end

  def test_it_finds_all_by_last_name
    results = customer_repository.find_all_by_last_name("Reynolds")
    assert_equal 3, results.count
  end

  def test_it_finds_all_by_created_at
    results = customer_repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, results.count
  end

  def test_it_finds_all_by_updated_at
    results = customer_repository.find_all_by_updated_at("2012-03-27 14:54:12 UTC")
    assert_equal 3, results.count
  end

end
