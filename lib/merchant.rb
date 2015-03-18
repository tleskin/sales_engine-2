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

  def invoices
    repository.find_all_invoices_by_merchant_id(id)
  end

  def transactions
    invoices.map {|invoice| invoice.transactions}.flatten
  end

  def pending_transactions
    invoices.select {|invoice| invoice.pending?}
  end

  def customers_with_pending_invoices
    pending_transactions.map {|invoice| invoice.customer}
  end


  ##revenue returns the total revenue for that merchant across all transactions
  # def revenue
  #   repository.
  #
  #   #get access to merchants items
  #   #get access to merchants quantity sold
  #   #calculation = items(unit price) * quanity(Invoice_item)
  # end

end
