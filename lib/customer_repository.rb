require_relative 'load_file'
require_relative 'customer'

class CustomerRepository

  attr_reader :customers, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @customers = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @customers = file.map do |row|
      Customer.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.detect {|customer| customer.id == id}
  end

  def find_by_first_name(first_name)
    customers.detect {|customer| customer.first_name == first_name}
  end

  def find_by_last_name(last_name)
    customers.detect {|customer| customer.last_name == last_name}
  end

  def find_by_created_at(created_at)
    customers.detect {|customer| customer.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    customers.detect {|customer| customer.updated_at == updated_at}
  end

  def find_all_by_id(id)
    customers.select { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.select do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.select do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_created_at(created_at)
    @customers.select {|customer| customer.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @customers.select {|customer| customer.updated_at == updated_at}
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer_id(id)
  end

end
