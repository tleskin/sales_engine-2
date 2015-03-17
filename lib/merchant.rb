require 'csv'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def items
    repository.find_all_items_by_merchant_id(id)
  end

  # def invoice
  #   repository.find_all_items_by_merchant_id
  # end

  # def customer_with_pending
  #
  # end
  #
  # def revenue_to_date
  #
  # end
end
