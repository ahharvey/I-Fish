class UserMailer < ActionMailer::Base
  default from: "admin@fishstat.com"

  def data_upload_success(user, excel_file)
    @user = user
    @excel_file = excel_file
    mail(:to => @user.email, :subject => "Excel Spreadsheet upload succesful")
  end

  def data_upload_failure(user, excel_file)
    @user = user
    @excel_file = excel_file
    mail(:to => @user.email, :subject => "Excel Spreadsheet upload failure")
  end
end
