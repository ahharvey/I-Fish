# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  god_mode               :boolean          default(FALSE)
#  reports_only           :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  office_id              :integer
#  avatar                 :string(255)
#  approved               :boolean          default(FALSE), not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  access_token           :string
#

class Admin < ActiveRecord::Base
  
  has_paper_trail
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :rememberable

  # Setup accessible (or protected) attributes for your model

  
  validates :name, presence: true
  validates :office, presence: true
  validates :email, presence: true, uniqueness: true
  validate :avatar_size

  has_and_belongs_to_many :roles, :before_add => :validates_role
  belongs_to :office
  has_one :district, through: :office
  has_one :province, through: :office
  has_many :surveys, dependent: :destroy
  has_many :reviewed_surveys, :class_name => 'Survey', :foreign_key => 'reviewer_id'
  has_many :surveys_as_landing_enumerator, :class_name => 'Survey', :foreign_key => 'landing_enumerator_id'
  has_many :surveys_as_catch_measurer, :class_name => 'Survey', :foreign_key => 'catch_measurer_id'
  has_many :surveys_as_catch_scribe, :class_name => 'Survey', :foreign_key => 'catch_scribe_id'
  has_many :logbooks
  has_many :approved_logbooks, :class_name => 'Logbook', :foreign_key => 'approver_id'
  has_many :activities, as: :ownable


  after_create :set_default_role
  after_create :send_approval_mail, unless: :created_by_invitation?
  before_create :generate_access_token

  # sets default role to public
  def set_default_role
    self.roles.push Role.find_by_name("enumerator")
    self.save!
  end

  # sends approval email to Supervisor
  def send_approval_mail
    for supervisor in self.office_supervisors
      UserMailer.new_admin_waiting_for_approval(self.id, supervisor.id).deliver_later
    end
  end

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

  def enumerator?
    has_role?("enumerator")
  end

  def public?
  	
  end

  def developer?
    has_role?("developer")
  end

  def has_role?(role)
  	self.roles.select{ |r| r.name == role }.count > 0
  end

  mount_uploader :avatar, AvatarUploader
#  validates :avatar, 
#    file_size: { 
#      maximum: 1.megabytes.to_i 
#    } 
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end
  
  #enables change avatar without password
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  #rollsback new role if exists
  def validates_role(role)
    
    if self.roles.include? role
      errors[:base] << "error in value enter male or female"
      raise ActiveRecord::Rollback 
    end
  end

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def firstname
    self.name.blank? ? "" : self.name.split(" ").first
  end
  
  def lastname
    self.name.blank? ? "" : self.name.split(" ").last
  end

  # modifies Devise send_reset_password_instructions to only send if Admin is approved
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def team_members
    Admin.where( office_id: self.office_id )
  end

  def office_supervisors
    office.supervisors
  end

  def member_fisheries
    office.member_fisheries
  end

  def managed_companies
    Company.all
  end

  def managed_vessels
    Vessel.where(company_id: managed_companies)
  end

  def managed_unloadings
    Unloading.where(vessel_id: managed_vessels)
  end

  def managed_carrier_loadings
    CarrierLoading.where(vessel_id: managed_vessels)
  end

  def managed_bait_loadings
    BaitLoading.where(unloading_id: managed_unloadings)
  end

  def supervised_surveys
    Survey.where( admin_id: self.team_members.each{|t| t.id } )
  end

  def self.pvr_managers
    Rails.cache.fetch([self, "pvr_managers"], expires_in: 5.minutes) do
      Admin.joins(:roles).where(roles: {name: ["pvr_coordinator"]})
    end
  end

  def created_by_invitation?
    invitation_created_at? && encrypted_password.blank? 
  end

  def pending_invitation?
    invitation_created_at? && invitation_accepted_at.blank?
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  private
 
  def avatar_size
    errors[:avatar] << "should be less than 1MB" if avatar.size > 1.megabytes
  end

  
  

end
