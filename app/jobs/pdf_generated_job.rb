class PdfGeneratedJob < ApplicationJob
  queue_as :default

  def perform(admin_id, filename, vessel_ids)
  	@vessels = Vessel.where(id: vessel_ids)
  	pdf = StickerPdf.new(@vessels)
  	file = StringIO.new(pdf.render) #mimic a real upload file
		file.class.class_eval { attr_accessor :original_filename, :content_type, :filename, :type } #add attr's that paperclip needs
		file.filename = file.original_filename = "your_report.pdf"
		file.type = file.content_type = "application/pdf"
	  generated_report = GeneratedReport.new
	  generated_report.file = file
	  generated_report.save!
	  UserMailer.generated_report_ready(admin_id, generated_report.id).deliver_later
	end
end
