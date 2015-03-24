require_relative 'load_file'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :invoices, :sales_engine

  include LoadFile

  def initialize(sales_engine)
    @invoices = []
    @sales_engine = sales_engine
  end

  def load_data(path)
    file = load_file(path)
    @invoices = file.map do |row|
      Invoice.new(row, self)
    end
    file.close
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  ## Find by methods

  def find_by_id(id)
    invoices.detect {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    invoices.detect {|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    invoices.detect {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    invoices.detect {|invoice| invoice.status == status}
  end

  def find_by_created_at(created_at)
    invoices.detect {|invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    invoices.detect {|invoice| invoice.updated_at == updated_at}
  end

  ## Find all by methods

  def find_all_by_id(id)
    invoices.select {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    invoices.select {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    invoices.select {|invoice| invoice.status == status}
  end

  def find_all_by_created_at(created_at)
    invoices.select {|invoice| invoice.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    invoices.select {|invoice| invoice.updated_at == updated_at}
  end

  ## Other methods

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer(id)
    sales_engine.find_customer_by_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end

  def create(inputs)
    row = {
      id:          "#{invoices.last.id + 1}",
      customer_id: inputs[:customer].id,
      merchant_id: inputs[:merchant].id,
      status:      inputs[:status],
      created_at:  "#{Date.new}",
      updated_at:  "#{Date.new}",
            }

    new_invoice = Invoice.new(row, self)
    invoices << new_invoice

    sales_engine.create_new_items_with_invoice_id(inputs[:items], new_invoice.id)
    new_invoice

  end

  def new_charge(card_info, id)
    sales_engine.new_charge(card_info, id)
  end

end
