require 'csv'
require_relative './merchant'

class MerchantRepository
  attr_reader :merchants
  attr_accessor :id,
                :name,
                :created_at,
                :updated_at

  def initialize(merchants)
    @merchants = merchants
  end

  def inspect
    "#<#{self.class} #{customer.size} rows>"
  end

  def self.load(file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Merchant.new(row)
    end
    new(rows)
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
  end

  def find_by_id(id)
    @merchants.detect {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchants.detect {|merchant| merchant.name == name}
  end

  def find_by_created_at(created_at)
    @merchants.detect {|merchant| merchant.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @merchants.detect {|merchant| merchant.updated_at == updated_at}
  end

  def find_all_by_name(name)
    @merchants.select {|merchant| merchant.name == name}
  end

  def find_all_by_created_at(created_at)
    @merchants.select {|merchant| merchant.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    @merchants.select {|merchant| merchant.updated_at == updated_at}
  end


end
