require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def sample_data
    {
      id: "1",
      customer_id: "2",
      merchant_id: "3",
      status: "shipped",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def setup
    @invoice = Invoice.new(sample_data, self)
  end

  def test_it_exists
    assert Invoice
  end

  def test_it_has_an_id
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 2, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    assert_equal 3, invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at_time
    assert_equal "2014-06-14 12:12:12 UTC", invoice.created_at
  end

  def test_it_has_an_updated_at_time
    assert_equal "2014-06-30 14:15:05 UTC", invoice.updated_at
  end

end
