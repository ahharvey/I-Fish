class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :lockable, :timeoutable, :omniauthable #, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h

  validates :name, presence: true

  has_many :surveys, dependent: :destroy
  belongs_to :desa
  has_and_belongs_to_many :roles

  
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


  after_create :set_default_role

  def set_default_role
  	self.roles.push Role.find_by_name("public")
  	self.save!
  end

  # Ability Methods
  def admin?
  	false
  end

  def supervisor?
  	false
  end

  def staff?
  	false
  end

  def public?
  	has_role?("public")
  end

  def has_role?(role)
  	self.roles.select{ |r| r.name == role }.count > 0
  end
end
