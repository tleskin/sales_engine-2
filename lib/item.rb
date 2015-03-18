require 'bigdecimal'
class Item

  attr_accessor :id, :name, :merchant_id, :updated_at,
                :unit_price, :description, :created_at
                :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = (data[:unit_price].to_d)/100
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def invoice_items
     repository.find_invoice_item(id)
  end


  def merchant
    repository.find_merchant(merchant_id)
  end



end
