require_relative 'load_file'
require_relative 'item'

class ItemRepository
  attr_reader :items, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @items = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @items = file.map do |line|
      Item.new(line, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{items.size} rows>"
  end

  def all
    items
  end

  def random
    items.sample
  end

  ## Find by methods

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

  ## Find all by methods

  def find_all_by_id(id)
    items.select {|item| item.id == id}
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

  ## Other methods

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end
end
