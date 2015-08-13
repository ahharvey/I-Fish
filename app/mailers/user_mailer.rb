class UserMailer < ActionMailer::Base
  default from: "no-reply@i-fish.net"

  def data_upload_success(admin_id, excel_file_id)
    @admin = Admin.find(admin_id)
    @excel_file = Excel_file.find(excel_file_id)
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload succesful")
  end

  def data_upload_failure(admin_id, excel_file)
    @admin = Admin.find(admin_id)
    @excel_file = excel_file
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload failure")
  end

  def import_success(owner_id, owner_type, rows = {})
    @owner = owner_type.constantize.find(owner_id)
    @rows = rows
    mail(:to => @owner.email, :subject => "Spreadsheet imported succesful")
  end

  def import_failure(owner_id, owner_type, errors ) 
    @owner = owner_type.constantize.find(owner_id)
    @errors = errors
    mail(:to => @owner.email, :subject => "Spreadsheet import failed")
  end

  def new_admin_waiting_for_approval(new_admin_id, supervisor_id)
    @admin      = Admin.find(new_admin_id)
    @supervisor = Admin.find(supervisor_id)
    @url        = new_admin_session_url
    mail( to: @supervisor.email, subject: "APPROVAL REQUEST :: New Team Member")
  end

  def new_data_waiting_for_approval(survey_id)
    @survey = Survey.find(survey_id)
    @uploader = @survey.admin
    @supervisors = @uploader.supervisors
    @url = supervisor_dashboard_index_url
    mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Survey Data")
  end
  
  def data_upload_failure_no_attachment(admin_id, options= {} )
    @admin = Admin.find(admin_id)
    @attachments = options[:attachments].blank? ? [] : options[:attachments]
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload failure")
  end

  def data_upload_failure_email_not_recognized(sender)
    @email = sender
    mail(:to => @email, :subject => "Excel Spreadsheet upload failure")
  end

  def new_admin_approved(admin_id)
    @admin = Admin.find(admin_id)
    @url = new_admin_session_url
    mail(:to => @admin.email, :subject => "I-Fish Registration Approved")
  end

  def new_pvr_application(vessel_id, admin_id)
    @vessel = Vessel.find(vessel_id)
    @admin = Admin.find(admin_id)
    @url = vessel_url(@vessel)
    mail(
      to: @admin.email,
      subject: "AP2HI request for UVI"
      )
  end

  def generated_report_ready(admin_id, generated_report_id)

    @admin = Admin.find(admin_id)
    @report = GeneratedReport.find(generated_report_id)
    mail(:to => @admin.email, :subject => "I-FISH :: Generated PDF ready for download")
  end
  
end
