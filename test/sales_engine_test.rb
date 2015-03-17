require_relative 'test_helper'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test

  attr_reader :engine, :invoice_repository,
              :item_repository, :customer_repository,
              :merchant_repository, :invoice_items

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
    item = engine.item_repository.find_by_unit_price BigDecimal.new("751.07")
    assert_equal BigDecimal.new("751.07"), item.unit_price


  end

  def test_invoice_item_repository_exists_on_engine_start_up
    assert_equal 21687, engine.invoice_item_repository.invoice_items.count
    results = engine.invoice_item_repository.find_by_item_id(539)
    assert_equal 539, results.item_id
  end

  def test_transaction_repository_exists_on_engine_start_up
    assert_equal 5595, engine.transaction_repository.transactions.count
    results = engine.transaction_repository.find_by_credit_card_number("4654405418249632")
    assert_equal "4654405418249632", results.credit_card_number
  end
end
