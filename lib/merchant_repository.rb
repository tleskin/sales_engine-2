require_relative 'load_file'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @merchants = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @merchants = file.map do |row|
      Merchant.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  ## Find by methods

  def find_by_id(id)
    merchants.detect {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.detect {|merchant| merchant.name == name}
  end

  def find_by_created_at(created_at)
    merchants.detect {|merchant| merchant.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    merchants.detect {|merchant| merchant.updated_at == updated_at}
  end

  ## Find all by methods

  def find_all_by_id(id)
    merchants.select {|merchant| merchant.id == id}
  end

  def find_all_by_name(name)
    merchants.select {|merchant| merchant.name == name}
  end

  def find_all_by_created_at(created_at)
    merchants.select {|merchant| merchant.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    merchants.select {|merchant| merchant.updated_at == updated_at}
  end

  ## BI methods

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(x)
    merchants.sort_by do |merchant|
    merchant.revenue
    end.reverse.first(x)
  end

  def most_items(x)
    merchants.sort_by do |merchant|
      merchant.quantity_successful_items
    end.reverse.first(x)
  end

  def revenue(date)
    merchants.map do |merchant|
      merchant.revenue(date)
    end.reduce(:+)
  end
end
