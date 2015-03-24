require_relative 'load_file'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @invoice_items = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @invoice_items = file.map do |row|
      InvoiceItem.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  ## Find by methods

  def find_by_id(id)
    invoice_items.detect {|item| item.id == id}
  end

  def find_by_item_id(item_id)
    invoice_items.detect {|item| item.item_id == item_id}
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.detect {|item| item.item_id == item_id}
  end

  def find_by_quantity(quantity)
    invoice_items.detect {|item| item.quantity == quantity}
  end

  def find_by_unit_price(unit_price)
    invoice_items.detect {|item| item.unit_price == unit_price}
  end


  def find_by_created_at(created_at)
    invoice_items.detect {|item| item.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    invoice_items.detect {|item| item.updated_at == updated_at}
  end

  ## Find all by methods

  def find_all_by_id(id)
    invoice_items.select { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select {|item| item.invoice_id == invoice_id}
  end

  def find_all_by_quantity(quantity)
    invoice_items.select {|item| item.quantity == quantity}
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.select {|item| item.unit_price == unit_price}
  end

  def find_all_by_created_at(created_at)
    @invoice_items.select{|item| item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @invoice_items.select {|item|item.updated_at == updated_at}
  end

  ## Other methods

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
  end

  def find_item(item_id)
    sales_engine.find_item_by_id(item_id)
  end

  def create_new_items(items, id)
     items.each do |item|
       grouped_items = items.group_by do |item|
         item
       end
       quantity = grouped_items.flat_map do |item|
         item.count
       end.uniq.join
       row = {
         id:         "#{invoice_items.last.id + 1}",
         item_id:    item.id,
         invoice_id: id,
         quantity:   quantity,
         unit_price: item.unit_price,
         created_at: "#{Date.new}",
         updated_at: "#{Date.new}"
        }

      new_invoice_item = InvoiceItem.new(row, self)
      invoice_items << new_invoice_item
     end
   end

end
