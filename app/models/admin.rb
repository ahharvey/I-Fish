class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :office_id, :avatar, :crop_x, :crop_y, :crop_w, :crop_h

  validates :name, presence: true

  has_and_belongs_to_many :roles
  belongs_to :office
  has_many :surveys, dependent: :destroy

  # after_create :set_default_role

  # def set_default_role
  # 	self.roles.push Role.find_by_name("administrator")
  # 	self.save!
  # end

  # Ability Methods
  def admin?
  	has_role?("administrator")
  end

  def supervisor?
  	has_role?("supervisor")
  end

  def staff?
  	has_role?("staff")
  end

  def public?
  	has_role?("public")
  end

  def has_role?(role)
  	self.roles.select{ |r| r.name == role }.count > 0
  end

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
