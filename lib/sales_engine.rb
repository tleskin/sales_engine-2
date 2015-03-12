require 'csv'
require_relative './merchant_repository'

class SalesEngine
  attr_accessor :filepath, :merchant_repository

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    @merchant_repository = MerchantRepository.new(filepath)
    file_path = "#{@filepath}/merchants.csv"
    @merchants = CSV.open(file_path,
                          headers: true,
                          header_converters: :symbol
                          )
  end
end


if __FILE__ == $0
engine = SalesEngine.new("/data")
engine.startup
engine.merchant_repo
end
