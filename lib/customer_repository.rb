require 'csv'
require_relative 'customer'

class CustomerRepository

  attr_reader :customers, :sales_engine

  def initialize(customers, sales_engine)
    @customers = customers
    @sales_engine = sales_engine
  end

  def self.load(sales_engine, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Customer.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end

  def find_by_id(id)
    @customers.detect {|customer| customer.id == id}
  end

  def find_by_first_name(first_name)
    @customers.detect {|customer| customer.first_name == first_name}
  end

  def find_by_last_name(last_name)
    @customers.detect {|customer| customer.last_name == last_name}
  end

  def find_by_created_at(created_at)
    @customers.detect {|customer| customer.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @customers.detect {|customer| customer.updated_at == updated_at}
  end

  def find_all_by_first_name(first_name)
    @customers.select {|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    @customers.select {|customer| customer.last_name == last_name}
  end

  def find_all_by_created_at(created_at)
    @customers.select {|customer| customer.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @customers.select {|customer| customer.updated_at == updated_at}
  end

end
