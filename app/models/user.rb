class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  # Associations
  has_one_attached :avatar
  has_many :tweets
  has_many :likes
  # Validations
  validates :username, :name, presence: true
  validates :username, uniqueness: true
  
  enum role: { contributor: 0, admin: 1}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.nickname
      user.name = auth.info.name
      # user.avatar = url_for(auth.info.image)
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
end
