require 'csv'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './item_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'

class SalesEngine
  attr_reader :merchant_repository, :file_path,
              :invoice_repository, :item_repository,
              :invoice_item_repository, :transaction_repository,
              :customer_repository

  def initialize(file_path = "./data")
    @file_path = file_path
  end

  def startup
    merchant_repository
    invoice_repository
    item_repository
    customer_repository
    transaction_repository
    invoice_item_repository
  end

  def merchant_repository
    @merchant_repository = MerchantRepository.load(self, "#{file_path}/merchants.csv")
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.load(self, "#{file_path}/invoices.csv")
  end

  def item_repository
    @item_repository = ItemRepository.load(self, "#{file_path}/items.csv")
  end

  def customer_repository
    @customer_repository = CustomerRepository.load(self, "#{file_path}/customers.csv")
  end

  def transaction_repository
    @transaction_repository = TransactionRepository.load(self, "#{file_path}/transactions.csv")
  end

  def invoice_item_repository
    @invoice_item_repository = InvoiceItemRepository.load(self, "#{file_path}/invoice_items.csv")
  end

end
#
#
# if __FILE__ == $0
# engine = SalesEngine.new("/data")
# engine.startup
# engine.merchant_repo
# end
