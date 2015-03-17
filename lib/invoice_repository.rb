require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :invoices, :sales_engine

  def initialize(invoices, sales_engine)
    @invoices = invoices
    @sales_engine = sales_engine
  end

  def self.load(sales_engine, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def all
    @invoices
  end

  def random
    @invoices.sample
  end

  def find_by_id(id)
    @invoices.detect {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    @invoices.detect {|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    @invoices.detect {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    @invoices.detect {|invoice| invoice.status == status}
  end

  def find_by_created_at(created_at)
    @invoices.detect {|invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @invoices.detect {|invoice| invoice.updated_at == updated_at}
  end

  def find_all_by_customer_id(customer_id)
    @invoices.select {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @invoices.select {|invoice| invoice.status == status}
  end

  def find_all_by_created_at(created_at)
    @invoices.select {|invoice| invoice.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @invoices.select {|invoice| invoice.updated_at == updated_at}
  end

  def find_all_transactions_by_invoice_id(id)
    @engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_invoice_items_by_invoice_id(id)
    @engine.find_all_invoice_items_by_invoice_id(id)
  end

end
