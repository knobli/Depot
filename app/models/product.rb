class Product < ActiveRecord::Base
  attr_accessible :available, :description, :image_url, :price, :title
  validates_presence_of :title, :description, :image_url
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'must be a URL for GIF, JPG or PNG image.'}
  validate :validate_description
  
  #check if the description
  protected
  def validate_description
    return unless self.validate_description_length
    errors.add(:fields,"Description does no match with the criterias")
  end  

  protected
  def validate_description_length
    if self.description.match(/[\d\w]{30}/)
      return false
    end
    return true
  end  
    
end
