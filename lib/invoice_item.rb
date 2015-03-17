require 'csv'
require 'bigdecimal'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id,
              :quantity, :unit_price, :created_at,
              :updated_at, :sales_engine

  def initialize (data, sales_engine)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = data[:unit_price].to_d/100
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def item
    sales_engine.item_repository.find_by_id(item_id)
  end
end
