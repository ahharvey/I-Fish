module BaseVessel

	def self.included(base)
    base.belongs_to :vessel_type
	  base.belongs_to :gear
	  base.belongs_to :company

	  base.validates :sipi_expiry, 
	    timeliness: {
	      type: :date
	    }
  	base.before_validation :save_formatted_sipi_expiry 
  	
  	base.scope :default, -> { order('vessels.ap2hi_ref ASC') }
  	
	  attr_writer :formatted_sipi_expiry
	  attr_accessor :return_to
	  base.has_paper_trail
  end

	MATERIAL_TYPES = ["wood", "fiber"]
	MACHINE_TYPES = ["none", "outboard", "inboard"]
	RELATIONSHIP_TYPES = ["contracted", "independent"]

  def formatted_sipi_expiry
    @formatted_sipi_expiry || sipi_expiry.try(:to_s, :long)
  end
  
  def save_formatted_sipi_expiry
    self.sipi_expiry = Chronic.parse(@formatted_sipi_expiry) if @formatted_sipi_expiry.present?
  end
end


