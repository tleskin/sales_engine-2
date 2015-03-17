require 'bigdecimal'
class Item

  attr_accessor :id, :name, :merchant_id, :updated_at,
                :unit_price, :description, :created_at
                :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = (data[:unit_price].to_d)/100
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end
end
