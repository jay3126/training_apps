class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :client_applications
  has_many :tokens, :class_name=>"Oauth2Token",:order=>"authorized_at desc",:include=>[:client_application]

end
