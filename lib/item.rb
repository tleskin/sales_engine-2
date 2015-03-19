require 'bigdecimal'
class Item

  attr_reader :id,
              :name,
              :merchant_id,
              :updated_at,
              :unit_price,
              :description,
              :created_at,
              :repository

  def initialize(line, repository)
    @id = line[:id].to_i
    @name = line[:name]
    @description = line[:description]
    @unit_price = BigDecimal.new(line[:unit_price])/100
    @merchant_id = line[:merchant_id].to_i
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
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
