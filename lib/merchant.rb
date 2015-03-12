require 'csv'


#PseudoCode

#Merchant Class will have the following attributes
  #id (id will be shared with InvoiceClass and ItemClass)
  #name
  #created_at
  #updated_at

#MerchantClass will have the following methods
  #Parse Method
  #Items Method
  #Invoice Method

#MerchantClass will have the following Business Intelligence Methods
  #Customer with Pending
  #Revenue(date)
  #Revenue
  #Fav Customer



class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def all
    @merchant
  end

  def items

  end

  def invoice

  end

  def customer_with_pending

  end

  def revenue_to_date

  end
end
