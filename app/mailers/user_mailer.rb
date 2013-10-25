class UserMailer < ActionMailer::Base
  default from: "i-fish@imacsindonesia.com"

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

  def new_admin_waiting_for_approval(new_admin, supervisors)
    if supervisors.length > 0
      @admin = new_admin
      @supervisors = supervisors
      @url  = new_admin_session_url
      mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Team Member")
    end
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
  
end
