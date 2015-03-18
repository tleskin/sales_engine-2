require 'csv'
require_relative 'item'
require 'bigdecimal'
require 'bigdecimal/util'

class ItemRepository

  attr_reader :items, :sales_engine

  def initialize(items, sales_engine)
    @items = items
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def self.load(sales_engine, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Item.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.detect {|item| item.id == id}
  end

  def find_by_name(name)
    items.detect {|item| item.name == name}
  end

  def find_by_description(description)
    items.detect {|item| item.description == description}
  end

  def find_by_unit_price(unit_price)
    items.detect {|item| item.unit_price == unit_price}
  end

  def find_by_merchant_id(merchant_id)
    items.detect {|item| item.merchant_id == merchant_id}
  end

  def find_by_created_at(created_at)
    items.detect {|item| item.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    items.detect {|item| item.updated_at == updated_at}
  end

  def find_all_by_name(name)
    items.select {|item| item.name == name}
  end

  def find_all_by_description(description)
    items.select {|item| item.description == description}
  end

  def find_all_by_unit_price(unit_price)
    items.select {|item| item.unit_price == unit_price.to_d/100}
  end

  def find_all_by_merchant_id(merchant_id)
    items.select {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_created_at(created_at)
    items.select {|item| item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    items.select {|item| item.updated_at == updated_at}
  end

  def find_invoice_item(id)
    items.find_invoice_item_by_item_id(id)
  end


end
