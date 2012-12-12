# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ExportXls::Application.initialize!

Date::DATE_FORMATS[:timedate] = "%d %b %y, %H:%M"