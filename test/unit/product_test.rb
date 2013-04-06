require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  
  test "error during validation" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positiv" do
    product = Product.new(:title => "My Test Book", :description => "Test description dasdf asdf asdf asdf asdf asdf", :image_url => "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    
    product.price = 1
    assert product.valid?
  end
end
