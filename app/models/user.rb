class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :lockable, :timeoutable, :omniauthable #, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :roles

  validates :name, presence: true
  has_many :surveys, dependent: :destroy
  has_and_belongs_to_many :roles
  belongs_to :desa

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
end
