require_relative 'test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    assert Invoice
  end

end
