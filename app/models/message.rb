class Message
  attr_accessor :content, :email, :name, :phone, :subject
  
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  validates :content, presence: true
  validates :email, presence: true
  validates :name, presence: true
  

end