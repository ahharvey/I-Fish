class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  
  validates :name, presence: true
  has_many :surveys, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
end
