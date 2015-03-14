require_relative 'test_helper'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  attr_reader :engine, :invoice_repository, :item_repository, :customer_repository, :merchant_repository,
  :invoice_items

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_it_exists
    assert SalesEngine
  end

  def test_merchant_repository_exists_on_engine_start_up
    assert_equal 100, engine.merchant_repository.merchants.count
    assert_equal "Schroeder-Jerde", engine.merchant_repository.merchants.first.name
  end

  def test_invoice_repository_exists_on_engine_start_up
    assert_equal 4843, engine.invoice_repository.invoices.count
    assert_equal 4843, engine.invoice_repository.all.count
  end

  def test_item_repository_exists_on_engine_start_up
    assert_equal 2483, engine.item_repository.items.count
    results = engine.item_repository.find_by_name("Item Qui Esse")
    assert_equal "Item Qui Esse", results.name
  end

end
