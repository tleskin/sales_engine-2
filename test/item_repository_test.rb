require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :item_repository

  def setup
    @item_repository = ItemRepository.load(self, './test/test_fixtures/items_sample.csv')
  end

  def test_it_exists
    assert ItemRepository
  end

  def test_that_item_repo_contains_item_data
    assert_equal 19, item_repository.items.count
  end

  def test_merchant_repo_is_not_empty
    refute item_repository.items.empty?
  end

  def test_it_returns_all_items_records
    assert_equal 19, item_repository.all.count
  end

  def test_it_grabs_a_random_item
    item = @item_repository.random
    assert_equal Item, item.class
  end

  def test_it_finds_an_item_by_id
     results = item_repository.find_by_id(1)
     assert_equal 1, results.id
  end

  def test_it_finds_an_item_by_name
     results = item_repository.find_by_name("Item Qui Esse")
     assert_equal "Item Qui Esse", results.name
  end

  def test_it_finds_an_item_by_description
    results = item_repository.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", results.description
  end

  def test_it_finds_an_item_by_unit_price
    results = item_repository.find_by_unit_price(BigDecimal.new("751.07"))
    assert_equal BigDecimal.new("751.07"), results.unit_price
  end

  def test_it_finds_an_item_by_created_at
     results = item_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
     assert_equal "2012-03-27 14:53:59 UTC", results.created_at
  end

  def test_it_finds_an_item_by_updated_at
     results = item_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
     assert_equal "2012-03-27 14:53:59 UTC", results.created_at
  end

  def test_it_finds_an_item_by_merchant_id
     results = item_repository.find_by_merchant_id(1)
     assert_equal 1, results.merchant_id
  end

  def test_it_finds_all_by_name
    results = item_repository.find_all_by_name("Item Qui Esse")
    assert_equal 1, results.count
  end

  def test_it_finds_all_items_by_description
    results = item_repository.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
    assert_equal 1, results.count
  end

  def test_it_finds_all_items_by_unit_price
    assert_equal 1, item_repository.find_all_by_unit_price(BigDecimal.new("75107")).count
  end

  def test_it_finds_all_items_by_merchant_id
     results = item_repository.find_all_by_merchant_id(1)
     assert_equal 15, results.count
  end

  def test_it_finds_all_by_created_at
    results = item_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 19, results.count
  end

  def test_it_finds_all_by_updated_at
    results = item_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 19, results.count
  end
end
