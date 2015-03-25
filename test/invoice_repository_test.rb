require_relative 'test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.new(nil)
    invoice_repository.load_data('./test/test_fixtures/invoices_sample.csv')
  end

  def test_it_exists
    assert InvoiceRepository
  end

  def test_that_invoice_repository_contains_invoice_data
    assert invoice_repository.invoices
  end

  def test_it_returns_all
    assert_equal 10, invoice_repository.all.count
  end

  def test_it_returns_a_random_invoice
    invoice = invoice_repository.random
    assert_equal Invoice, invoice.class
  end

  def test_it_finds_an_invoice_by_id
     results = invoice_repository.find_by_id(1)
     assert_equal 1, results.id
  end

  def test_it_finds_an_invoice_by_customer_id
    results = invoice_repository.find_by_customer_id(1)
    assert_equal 1, results.customer_id
  end

  def test_it_finds_an_invoice_by_merchant_id
    results = invoice_repository.find_by_merchant_id(26)
    assert_equal 26, results.merchant_id
  end

  def test_it_finds_an_invoice_by_status
    results = invoice_repository.find_by_status("shipped")
    assert_equal "shipped", results.status
  end

  def test_it_can_find_by_created_at
    result = invoice_repository.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))
    assert_equal 1, result.id
  end

  def test_it_finds_an_invoice_by_updated_at
     results = invoice_repository.find_by_updated_at("2012-03-25 09:54:09 UTC")
     assert_equal "2012-03-25 09:54:09 UTC", results.updated_at
  end

  def test_finds_all_invoices_by_customer_id
    results = invoice_repository.find_all_by_customer_id(1)
    assert_equal 8, results.count
  end

  def test_it_finds_all_invoices_by_merchant_id
    results = invoice_repository.find_all_by_merchant_id(26)
    assert_equal 2, results.count
  end

  def test_it_finds_all_invoices_by_status
    results = invoice_repository.find_all_by_status("shipped")
    assert_equal 10, results.count
  end

  def test_it_finds_all_invoices_by_created_at
    results = invoice_repository.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 0, results.count
  end

  def test_it_finds_all_invoices_by_updated_at
    results = invoice_repository.find_all_by_updated_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, results.count
  end

  def test_invoice_repo_has_a_create_method
    sales_engine = SalesEngine.new('./test_fixtures')
    sales_engine.startup
    invoice_repo = sales_engine.invoice_repository
    assert invoice_repo.respond_to?(:create)
  end

  def test_new_charge_creates_a_new_transaction
    sales_engine = SalesEngine.new("./test_fixtures")
    sales_engine.startup
    invoice_repo = sales_engine.invoice_repository
    prior_transactions = sales_engine.transaction_repository.transactions.count
    invoice_repo.invoices.first.charge(credit_card_number: "4444333322221111", credit_card_expiration: "10/13", result: "success")
    current_transactions = sales_engine.transaction_repository.transactions.count
    assert current_transactions > prior_transactions
  end

  def test_it_can_talk_to_the_sales_engine_with_find_item
    engine = Minitest::Mock.new
    invoice_item_repository = InvoiceItemRepository.new(engine)
    engine.expect(:find_item_by_id, "sample", [1])
    assert_equal "sample", invoice_item_repository.find_item(1)
  end



end
