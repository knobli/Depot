class Product < ActiveRecord::Base
  attr_accessible :available, :description, :image_url, :price, :title
end
