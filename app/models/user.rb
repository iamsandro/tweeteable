class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %I[github google_oauth2]


  # Associations
  has_one_attached :avatar
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_token
  # Validations
  validates :username, :name, presence: true
  validates :username, uniqueness: true
  
  enum role: { contributor: 0, admin: 1}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      auth.info.nickname ? (user.username = auth.info.nickname) : (user.username = auth.info.first_name)
      user.name = auth.info.name
      # user.avatar = url_for(auth.info.image)
      # user.avatar.attach(io: File.open(auth.info.picture), filename: "#{first_name}.jpg")
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def invalidate_token
    update(token: nil)
  end
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end
end
