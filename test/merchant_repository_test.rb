require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'

class MerchantRepoTest < Minitest::Test

  attr_reader :merchant_repository

  def test_it_exists
    assert MerchantRepository
  end

  def setup
    @merchant_repository = MerchantRepository.new(nil)
    merchant_repository.load_data('./test/test_fixtures/merchants_sample.csv')
  end

  def test_that_merchant_repo_contains_merchant_data
    assert_equal 20, merchant_repository.merchants.count
  end

  def test_merchant_repo_is_not_empty
    refute merchant_repository.merchants.empty?
  end

  def test_it_returns_all_merchant_records
    assert_equal 20, merchant_repository.all.count
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

  def test_it_finds_all_by_id
    results = merchant_repository.find_all_by_id(1)
    assert_equal 1, results.count
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

  def test_it_can_talk_to_sales_engine_with_find_items
    sales_engine = Minitest::Mock.new
    merchant_repository = MerchantRepository.new(sales_engine)
    sales_engine.expect(:find_items_by_merchant_id, [1, 2], [1])
    assert_equal [1, 2], merchant_repository.find_items(1)
    sales_engine.verify
  end

  def test_it_can_find_most_revenue
    sales_engine = SalesEngine.new("./test_fixtures")
    sales_engine.startup
    result = sales_engine.merchant_repository.most_revenue(2)
    assert_equal 2, result.count
    assert result.is_a?(Array)
    assert result[1].is_a?(Merchant)
  end

  def test_it_can_find_most_items
    sales_engine = SalesEngine.new("./test_fixtures")
    sales_engine.startup
    result = sales_engine.merchant_repository.most_items(1)
    assert_equal "Schulist, Wilkinson and Leannon", result.first.name
  end

  def test_it_can_return_all_revenues_for_given_date
    sales_engine = SalesEngine.new('./data')
    sales_engine.startup
    assert_equal BigDecimal, sales_engine.merchant_repository.revenue(Date.parse("2012-03-25")).class
    assert_equal 2830718, sales_engine.merchant_repository.revenue(Date.parse("2012-03-25")).to_i
  end

end
