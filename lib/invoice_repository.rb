require 'csv'
require_relative 'invoice'

def InvoiceRepository

  def initialize(invoice)
    @invoices = invoices
  end

  def self.load(file ='./data/invoice_items.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row)
    end
    new(rows)
  end





end
