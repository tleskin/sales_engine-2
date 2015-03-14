require 'csv'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './item_repository'

class SalesEngine
  attr_reader :merchant_repository, :file_path,
              :invoice_repository, :item_repository

  def initialize(file_path = "./data")
    @file_path = file_path
  end

  def startup
    merchant_repository
    invoice_repository

  end

  # def startup
  #   @merchant_repository = MerchantRepository.new(filepath, self)
  #   file_path = "#{@filepath}/merchants.csv"
  #   @merchants = CSV.open(file_path,
  #                         headers: true,
  #                         header_converters: :symbol
  #                         )
  # end

  def merchant_repository
    @merchant_repository = MerchantRepository.load(self, "#{file_path}/merchants.csv")
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.load(self, "#{file_path}/invoices.csv")
  end

  def item_repository
    @item_repository = ItemRepository.load(self, "#{file_path}/items.csv")
  end

end
#
#
# if __FILE__ == $0
# engine = SalesEngine.new("/data")
# engine.startup
# engine.merchant_repo
# end
