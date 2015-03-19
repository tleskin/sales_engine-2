require 'bigdecimal'
require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository


  def initialize(line, repository)
    @id = line[:id].to_i
    @name = line[:name]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
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

  def favorite_customer
    grouped_successful = successful_invoices.group_by {|invoice| invoice.customer_id}
    find_with_most_invoices = grouped_successful.max_by {|customer| customer[1].count}
    favorite_customer = find_with_most_invoices[-1][0].customer
  end

  ##revenue returns the total revenue for that merchant across all transactions
  # def revenue
  #   repository.
  #
  #   #get access to merchants items
  #   #get access to merchants quantity sold
  #   #calculation = items(unit price) * quanity(Invoice_item)
  # end
  #
  # def revenue(date = nil)
  #
  # end

  def revenue(date=nil)
   if date.nil?
     successful_invoices.reduce(0) {| sum, invoice |
       sum + (invoice.revenue)
     }
   else
     successful_invoices.select { |invoice| invoice.created_at == date }
      .reduce(0) { |sum, invoice|
        sum + invoice.revenue
      }
   end
 end


  private

  def successful_invoices
    successful_invoices = invoices.select {|invoice| invoice.successful?}
  end

end
