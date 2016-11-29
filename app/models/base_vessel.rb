class BaseVessel < ApplicationRecord
  belongs_to :vessel_type
  belongs_to :gear
  belongs_to :company

  validates :sipi_expiry,
    timeliness: {
      type: :date
    }

  has_paper_trail

  attr_accessor :return_to


  MATERIAL_TYPES = ["wood", "fiber"]
  MACHINE_TYPES = ["none", "outboard", "inboard"]
  RELATIONSHIP_TYPES = ["contracted", "independent"]


  attr_writer :formatted_sipi_expiry
  before_validation :save_formatted_sipi_expiry
  def formatted_sipi_expiry
    @formatted_sipi_expiry || sipi_expiry.try(:to_s, :long)
  end

  def save_formatted_sipi_expiry
    self.sipi_expiry = Chronic.parse(@formatted_sipi_expiry) if @formatted_sipi_expiry.present?
  end

end
