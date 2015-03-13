require 'csv'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def items

  end

  def invoice

  end

  def customer_with_pending

  end

  def revenue_to_date

  end
end
