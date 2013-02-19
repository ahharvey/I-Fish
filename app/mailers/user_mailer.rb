class UserMailer < ActionMailer::Base
  default from: "fishnet@imacsindonesia.com"

  def data_upload_success(admin, excel_file)
    @admin = admin
    @excel_file = excel_file
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload succesful")
  end

  def data_upload_failure(admin, excel_file)
    @admin = admin
    @excel_file = excel_file
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload failure")
  end

  def new_admin_waiting_for_approval(new_admin, supervisors)
    @admin = new_admin
    @supervisors = supervisors
    @url  = new_admin_session_url  
    mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Team Member")
  end

  def new_data_waiting_for_approval(data)
    @data = data
    @uploader = data.admin
    @supervisors = data.admin.supervisors
    @url = supervisor_dashboard_index_url
    mail(:to => @supervisors.all.map(&:email), :subject => "APPROVAL REQUEST :: New Survey Data")
  end
  
  def data_upload_failure_no_attachment(admin)
    @admin = admin
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload failure")
  end

  def data_upload_failure_email_not_recognized(admin)
    @admin = admin
    mail(:to => @admin.email, :subject => "Excel Spreadsheet upload failure")
  end
end
