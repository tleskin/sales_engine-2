require_relative 'test_helper'
require './lib/item.rb'
require './lib/sales_engine'

class ItemTest < Minitest::Test

  attr_reader :item

  def sample_data
    {
      id: "1",
      name: "Item Qui Esse",
      description: "Nihil autem sit odio inventore",
      unit_price: "75107",
      merchant_id: "2",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:54:59 UTC"
    }
  end

  def setup
    @item = Item.new(sample_data, nil)
  end

  def test_it_exists
    assert Item
  end

  def test_it_has_an_id
    assert_equal 1, @item.id
  end

  def test_it_has_a_name
    assert_equal "Item Qui Esse", @item.name
  end

  def test_it_has_a_description
    assert_equal "Nihil autem sit odio inventore", @item.description
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal.new("751.07"), @item.unit_price
  end

  def test_it_has_a_merchant_id
    assert_equal 2, @item.merchant_id
  end

  def test_it_has_a_created_date
    assert_equal "2012-03-27 14:53:59 UTC", @item.created_at
  end

  def test_it_has_an_updated_date
    assert_equal "2012-03-27 14:54:59 UTC", @item.updated_at
  end

  def test_it_can_talk_to_the_repository_with_invoices
    engine = Minitest::Mock.new
    item = Item.new(sample_data, engine)
    engine.expect(:find_invoice_items, [1, 2], [1])
    assert_equal [1, 2], item.invoice_items
  end

  def test_it_can_talk_to_the_repository_with_merchant
    engine = Minitest::Mock.new
    item = Item.new(sample_data, engine)
    engine.expect(:find_merchant, "sample", [2])
    assert_equal "sample", item.merchant
  end

  def test_it_can_find_its_best_day
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    item = sales_engine.item_repository.items[2]
    assert_equal "2012-03-10", item.best_day.to_s
  end
end
