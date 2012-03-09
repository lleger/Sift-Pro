class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :university_id
  
  belongs_to :university
  
  has_many :blacklists
  has_many :invitations, :class_name => "user", :as => :invited_by
  
  def connected_twitter?
    token.present? && secret.present?
  end
  
  def send_reset_password_instructions
    super if invitation_token.nil?
  end
end
