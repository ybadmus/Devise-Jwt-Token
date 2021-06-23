class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :jwt_authenticatable, :rememberable,
         :registerable, :validatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :posts
  has_many :comments
end
