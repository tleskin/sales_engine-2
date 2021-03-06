require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

   attr_reader :customer

   def sample_data
     {
      id: "1",
      first_name: "Joey",
      last_name: "Ondricka",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:55:09 UTC"
     }
   end

  def setup
    @customer = Customer.new(sample_data, nil)
  end

  def test_it_exists
    assert Customer
  end

  def test_it_has_an_id
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_date
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_an_updated_date
    assert_equal "2012-03-27 14:55:09 UTC", customer.updated_at
  end

  def test_it_can_get_its_favorite_merchant
    sales_engine = SalesEngine.new("./data")
    sales_engine.startup
    customer = sales_engine.customer_repository.customers[50]
    assert_equal "Rutherford, Bogan and Leannon", customer.favorite_merchant.name
  end

end
