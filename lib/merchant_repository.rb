require 'csv'
require_relative 'merchant'

class MerchantRepo
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def self.load(file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Merchant.new(row)
    end
    new(rows)
  end
end