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

  def test_that_merchant_repo_contains_merchant_data
    assert_equal 100, merchant_repo.merchants.count
  end

  def test_merchant_repo_is_not_empty
    refute merchant_repo.merchants.empty?
  end
end
