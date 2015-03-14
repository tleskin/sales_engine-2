require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepoTest < Minitest::Test

  attr_reader :merchant_repository

  def test_it_exists
    assert MerchantRepository
  end

  def setup
    @merchant_repository = MerchantRepository.load(self, './data/merchants.csv')
  end

  def test_that_merchant_repo_contains_merchant_data
    assert_equal 100, merchant_repository.merchants.count
  end

  def test_merchant_repo_is_not_empty
    refute merchant_repository.merchants.empty?
  end

  def test_it_returns_all_merchant_records
    merchant_repo = MerchantRepository.load(self, './data/merchants.csv')
    assert_equal 100, merchant_repository.all.count
  end

  def test_it_grabs_a_random_merchant
    merchant = @merchant_repository.random
    assert_equal Merchant, merchant.class
  end

  def test_it_finds_a_merchant_by_id
     results = merchant_repository.find_by_id(1)
     assert_equal 1, results.id
  end

  def test_it_finds_a_merchant_by_name
     results = merchant_repository.find_by_name("Schroeder-Jerde")
     assert_equal "Schroeder-Jerde", results.name
  end

  def test_it_finds_a_merchant_by_created_at
     results = merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
     assert_equal "2012-03-27 14:53:59 UTC", results.created_at
  end

  def test_it_finds_a_merchant_by_updated_at
     results = merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
     assert_equal "2012-03-27 14:53:59 UTC", results.created_at
  end

  def test_it_finds_all_by_name
    results = merchant_repository.find_all_by_name("Williamson Group")
    assert_equal 2, results.count
  end

  def test_it_finds_all_by_created_at
    results = merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 9, results.count
  end

  def test_it_finds_all_by_updated_at
    results = merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 8, results.count
  end

end
