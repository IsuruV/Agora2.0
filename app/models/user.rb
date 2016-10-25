class User < ApplicationRecord
  has_many :lists

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         devise :omniauthable, :omniauth_providers => [:facebook]

         def self.from_omniauth(auth)
           where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
             user.email = auth.info.email
             user.password = Devise.friendly_token[0,20]
           end
         end

  def creat_default_lists
    self.listings.find_or_create_by(name:"Brooklyn")
    self.listings.find_or_create_by(name:"Queens")
    self.listings.find_or_create_by(name:"Manhattan")
    self.listings.find_or_create_by(name:"Bronx")
    self.listings.find_or_create_by(name:"Staten Island")
  end

end
