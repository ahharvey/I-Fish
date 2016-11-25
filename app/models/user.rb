# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  desa_id                :integer
#  avatar                 :string(255)
#  vessel_type_id         :integer
#  engine_id              :integer
#  power                  :integer
#  length                 :integer
#  notes                  :text
#

class User < ActiveRecord::Base

  has_paper_trail

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :lockable, :timeoutable, :omniauthable, :invitable # :confirmable


  validates :email, presence: true, uniqueness: true
  validate :avatar_size

  belongs_to :desa
  has_and_belongs_to_many :roles, :before_add => :validates_role
  has_many :logbooks
  has_many :activities, as: :ownable

  has_many :documents, as: :documentable
  has_many :companies, through: :company_positions
  has_many :company_positions


  mount_uploader :avatar, AvatarUploader
#  validates :avatar,
#    file_size: {
#      maximum: 1.megabytes.to_i
#    }

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h #,:password, :password_confirmation, :current_password
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
    self.roles.push Role.where(name: "public").first_or_create
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

  def validates_role(role)
    raise ActiveRecord::Rollback if self.roles.include? role
  end

  def firstname
    self.name.blank? ? "" : self.name.split(" ").first
  end

  def lastname
    self.name.blank? ? "" : self.name.split(" ").last
  end

  def managed_vessels
    Vessel.where(company_id: companies.map(&:id))
  end

  def pending_invitation?
    false
  end

  private

  def avatar_size
    errors[:avatar] << "should be less than 1MB" if avatar.size > 1.megabytes
  end



end
