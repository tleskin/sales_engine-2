require 'bigdecimal'
require 'bigdecimal/util'
class Item

  attr_reader :id,
              :name,
              :merchant_id,
              :updated_at,
              :unit_price,
              :description,
              :created_at,
              :repository

  def initialize(row, repository)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def invoice_items
     repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def best_day
    most_sold = invoice_items.max_by { |invoice_item| invoice_item.quantity }
    date      = most_sold.invoice.created_at
  end


end
