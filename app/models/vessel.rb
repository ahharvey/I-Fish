class Vessel < ActiveRecord::Base
  belongs_to :vessel_type
  belongs_to :gear
  belongs_to :company
  has_many :documents, as: :documentable

  has_paper_trail

  attr_accessor :return_to

  before_save :send_pvr_request

  private

  def send_pvr_request
    if issf_ref_requested_changed? && issf_ref_requested?
      admins = Admin.pvr_managers
      for admin in admins
        UserMailer.new_pvr_application(self.id, admin.id).deliver_later
      end
    end
  end
end
