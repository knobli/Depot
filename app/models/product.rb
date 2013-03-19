class Product < ActiveRecord::Base
  attr_accessible :available, :description, :image_url, :price, :title
  validate :validate_description_length
  
  #check if the description
  protected
  def validate_description
    return unless self.validate_description_length
    errors.add(:fields,"Description does no match with the criterias")
  end  

  protected
  def validate_description_length
    if ! /[\d\w]{30}/.match(self.description)
      return false
    end
    return true
  end  
    
end
