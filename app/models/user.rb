class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h


  validates :name, presence: true
  has_many :surveys, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar


  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end


  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    update_attributes(params)
  end

end
