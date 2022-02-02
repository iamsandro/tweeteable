class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Associations
  has_one_attached :avatar
  has_many :tweets
  has_many :likes
  # Validations
  validates :username, :name, presence: true
  validates :username, uniqueness: true
  
  enum role: { contributor: 0, admin: 1}
end
