require 'pry'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(line, repository)
    @id = line[:id].to_i
    @first_name = line[:first_name]
    @last_name = line[:last_name]
    @created_at = line[:created_at]
    @updated_at = line[:updated_at]
    @repository = repository
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.map {|invoice| invoice.transactions}.flatten
  end

  def favorite_merchant
    successful_invoices = invoices.select {|invoice| invoice.successful?}
    successful_merchants = successful_invoices.group_by {|invoice| invoice.merchant_id}
    find_most_successful = successful_merchants.max_by {|merchant| merchant[1].count}
    favorite_merchant = find_most_successful[-1][0].merchant
  end

end
