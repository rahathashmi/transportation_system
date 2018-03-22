class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :doorkeeper
  belongs_to :role
  belongs_to :company
  belongs_to :vehicle
  belongs_to :trip
  has_many :trips
  
  validates :company_id, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def admin?
    self.role&.name == "admin"
  end
  
  def read?
    self.role&.name == "read"
  end




  def generate_authentication_token
    application ||= Doorkeeper::Application.find_by(uid: Doorkeeper::Application.first.uid)
    access_token = Doorkeeper::AccessToken.find_or_create_for(application, self.id, 'public', true)
    access_token
  end

  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user.try(:valid_password?, password) ? user : nil
    end
  end
end
