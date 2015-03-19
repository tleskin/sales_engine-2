require_relative '../lib/sales_engine'
require_relative 'test_helper'
require './lib/merchant'
require 'bigdecimal/util'
require 'bigdecimal'

class MerchantTest < Minitest::Test

  attr_reader :merchant

  def sample_data
    {
      id: "1",
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
  end

  def setup
    @merchant = Merchant.new(sample_data, nil)
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_has_an_id
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_it_has_a_created_date
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_an_updated_date
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_can_talk_to_the_repository_with_items
    engine = Minitest::Mock.new
    merchant = Merchant.new(sample_data, engine)
    engine.expect(:find_items, [1, 2], [1])
    assert_equal [1, 2], merchant.items
  end

  def test_it_can_talk_to_the_repository_with_invoices
    engine = Minitest::Mock.new
    merchant = Merchant.new(sample_data, engine)
    engine.expect(:find_invoices, [1, 2], [1])
    assert_equal [1, 2], merchant.invoices
  end

  def test_it_can_find_the_favorite_customer
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    merchant = sales_engine.merchant_repository.merchants[50]
    assert_equal "Kuhn", merchant.favorite_customer.last_name
  end

  # def test_it_can_find_its_total_revenue_with_a_date
  #   sales_engine = SalesEngine.new("./data")
  #   sales_engine.startup
  #   assert_equal "24641.43", sales_engine.merchant_repository.merchants[2].revenue("2012-03-25").to_digits
  # end
  #
  # def test_it_can_find_total_revenue
  #   sales_engine = SalesEngine.new("./data")
  #   sales_engine.startup
  #   assert_equal "338055.54", sales_engine.merchant_repository.merchants[2].revenue.to_digits
  # end



end
