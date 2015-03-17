require_relative 'test_helper'
require './lib/item.rb'

class ItemTest < Minitest::Test

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
    @item = Item.new(sample_data, sales_engine=nil)
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
end
