require_relative 'test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :invoice_item_repository

  def test_it_exists
    assert InvoiceItemRepository
  end

  def setup
    @invoice_item_repository = InvoiceItemRepository.load(self, './test/test_fixtures/invoice_items_sample.csv')
  end

  def test_that_invoice_time_repository_contains_data
    assert_equal 20, invoice_item_repository.invoice_items.count
  end

  def test_invoice_item_repository_is_not_empty

    refute @invoice_item_repository.invoice_items.empty?
  end

  def test_it_returns_all_invoice_items
    assert_equal 20, invoice_item_repository.all.count
  end

  def test_it_grabs_a_random_invoice_item

    invoice_items = @invoice_item_repository.random
    assert_equal InvoiceItem, invoice_items.class
  end

  def test_it_finds_an_invoice_item_by_id
    results = @invoice_item_repository.find_by_id(1)
    assert_equal 1, results.id
  end

  def test_it_finds_an_invoice_item_by_item_id
    results = @invoice_item_repository.find_by_item_id(539)
    assert_equal 539, results.item_id
  end

  def test_it_finds_an_invoice_item_by_item_id
    results = @invoice_item_repository.find_by_item_id(539)
    assert_equal 539, results.item_id
  end

  def test_it_finds_an_invoice_item_created_at
    results = @invoice_item_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", results.created_at
  end

  def test_it_finds_an_invoice_item_by_updated_at

    results = invoice_item_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", results.updated_at
  end

  def test_it_finds_all_by_created_at

    results = invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, results.count
  end

  def test_it_finds_all_by_updated_at
    results = invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, results.count
  end

  def test_it_finds_all_by_quantity
    results = invoice_item_repository.find_all_by_quantity(5)
    assert_equal 5, results.count
  end

  def test_it_finds_invoice_item_by_quantity
    results = invoice_item_repository.find_by_quantity(5)
    assert_equal 5, results.quantity
  end
end
