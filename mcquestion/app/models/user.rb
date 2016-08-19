class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  serialize :role ,Array
  has_many :testusers 
  has_many :tests, through: :testusers
  def self.from_google(auth_token)
  	data = auth_token.info
  	user = User.where(:email => data["email"]).first
  	if !user
  		@user=User.create(name: data["name"],email: data["email"],password: Devise.friendly_token[0,20])
  		return @user
  	else
  		return user
  	end
  end
end
