require 'csv'
require_relative './invoice_items'

class InvoiceItemRepository
  attr_reader :invoice_items


  def initialize(invoice_items, sales_engine)
    @invoice_items = invoice_items
    @sales_engine = sales_engine
  end

  # def inspect
  #   "#<#{self.class} #{customer.size} rows>"
  # end

  def self.load(sales_engine, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      InvoiceItem.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.sample
  end

  def find_by_id(id)
    @invoice_items.detect {|item| item.id == id}
  end

  def find_by_item_id(item_id)
    @invoice_items.detect {|item| item.item_id == item_id}
  end

  def find_by_created_at(created_at)
    @invoice_items.detect {|item|item.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @invoice_items.detect {|item|item.updated_at == updated_at}
  end

  def find_all_by_created_at(created_at)
    @invoice_items.select{|item| item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @invoice_items.select {|item|item.updated_at == updated_at}
  end
end