require 'bigdecimal'
require 'bigdecimal/util'
require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository


  def initialize(row, repository)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
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

  def revenue(date=nil)
   if date.nil?
     successful_invoices.reduce(0) {| sum, invoice |
       sum + invoice.revenue
     }
   else
     successful_invoices.select { |invoice| invoice.created_at == date }
      .reduce(0) { |sum, invoice|
        sum + invoice.revenue
      }
   end
  end

 def quantity_successful_items
   successful_invoice_items = successful_invoices.flat_map do |invoice|
     invoice.items
   end.count
 end

  def successful_invoices
    @successful_invoices ||= invoices.select {|invoice| invoice.successful?}
  end

  def merchant_transactions
   @merchant_transactions ||= invoices.flat_map do |invoice|
     invoice.transactions
   end
 end

  def successful_transactions(merchant_transactions)
    @successful_transactions ||= merchant_transactions.select do |transaction|
      transaction.successful?
    end
  end

end
