require_relative 'test_helper'
require './lib/merchant_repository.rb'

class MerchantRepoTest < Minitest::Test

  attr_reader :merchant_repo
  
  def test_it_exists
    assert MerchantRepo
  end

  def setup
    @merchant_repo = MerchantRepo.load('./data/merchants.csv')
  end

  def test_that_merchant_repository_contants_merchant_data
    assert_equal 100, @merchant_repo.merchants.count
  end
end
