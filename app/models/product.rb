class Product < ActiveRecord::Base
  default_scope :order => 'title'
  attr_accessible :available, :description, :image_url, :price, :title
  validates_presence_of :title, :description, :image_url
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'must be a URL for GIF, JPG or PNG image.'}
  validate :validate_description
  
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #check if the description
  protected
  def validate_description
    return unless self.validate_description_length
    errors.add(:fields,"Description does no match with the criterias (min 30 characters long)")
  end  

  protected
  def validate_description_length
    if ! description.nil? && description.match(/[\w\s\d]{30}/)
      return false  
    end
    return true
  end
  
  private
  #ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end  
    
end
