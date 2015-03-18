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

  def items
    invoice_items.map { |invoice_item| invoice_item.item }
  end

  def customer
    repository.find_all_customers_by_customer_id(customer_id)
  end

  def pending?
    transactions.all? {|transaction| transaction.pending?}
  end

  def successful?
    transactions.all? {|transaction| transaction.successful?}
  end
end
