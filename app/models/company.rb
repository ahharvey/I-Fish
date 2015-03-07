class Company < ActiveRecord::Base
  has_paper_trail

  has_many :documents, as: :documentable
  has_many :vessels

  has_and_belongs_to_many :member_fisheries, class_name: "Company"

  validate :avatar_size

  mount_uploader :avatar, AvatarUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :fishery_id
  after_update :crop_avatar
  
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  private
 
  def avatar_size
    errors[:avatar] << "should be less than 1MB" if avatar.size > 1.megabytes
  end
end
