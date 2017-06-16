class RecoverPassword
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :password, presence: true, confirmation: true, length: {minimum: 8}


  attr_accessor :password, :password_confirmation

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end