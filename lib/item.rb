require 'bigdecimal'
require 'bigdecimal/util'
class Item

  attr_reader :id,
              :name,
              :merchant_id,
              :updated_at,
              :unit_price,
              :description,
              :created_at,
              :repository

  def initialize(row, repository)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def invoice_items
     repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def best_day
    most_sold.invoice.created_at
  end

  def revenue
    invoices_transactions = invoices_transactions(items_invoices)

    successful_transactions = successful_transactions(invoices_transactions)

    successful_invoices = successful_invoices(successful_transactions)

    successful_invoice_items = successful_invoice_items(successful_invoices)

    final_invoice_items = final_invoice_items(successful_invoice_items)

    invoice_item_revenue = final_invoice_items(successful_invoice_items).map do |invoice_item|
      invoice_item.revenue
    end
    invoice_item_revenue.reduce(:+)
  end

  def quantity_sold

   invoices_transactions = invoices_transactions(items_invoices)

   successful_transactions = successful_transactions(invoices_transactions)

   successful_invoices = successful_invoices(successful_transactions)

   successful_invoice_items = successful_invoice_items(successful_invoices)

   final_invoice_items = final_invoice_items(successful_invoice_items)

   final_invoice_items.flat_map do |invoice_item|
     invoice_item.quantity
   end.reduce(:+)
 end

 def items_invoices
   @items_invoices ||= invoice_items.map do |invoice_item|
     invoice_item.nil? ? [] : invoice_item.invoice
   end.uniq
 end

 def invoices_transactions(items_invoices)
   @invoices_transactions ||= items_invoices.flat_map do |invoice|
     invoice.transactions
   end
 end

 def successful_transactions(invoices_transactions)
   @successful_transactions ||= invoices_transactions.reject do |transaction|
     !transaction.successful?
   end
 end

 def successful_invoices(successful_transactions)
   @successful_invoices ||= successful_transactions.map do |transaction|
     transaction.invoice
   end
 end

 def successful_invoice_items(successful_invoices)
   @successful_invoice_items ||= successful_invoices.flat_map do |invoice|
     invoice.invoice_items
   end
 end

 def final_invoice_items(successful_invoice_items)
   @final_invoice_items ||= successful_invoice_items.select do |invoice_item|
    invoice_item.item_id == id
   end
 end

 def most_sold
   invoice_items.max_by { |invoice_item| invoice_item.quantity }
 end
end
