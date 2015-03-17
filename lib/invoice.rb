class Invoice

  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def transactions
    repository.find_all_transactions_by_invoice_id(id)
  end

  def invoice_items
    repository.find_all_invoice_items_by_invoice_id(id)
  end
end
