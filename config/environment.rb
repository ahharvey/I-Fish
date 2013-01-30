# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ExportXls::Application.initialize!

Time::DATE_FORMATS[:triptime] = "%H:%M (%b-%d)"