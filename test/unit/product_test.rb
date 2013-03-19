require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "error during validation" do 
    product = Product.new
    assert product.invalid?
  end
end
