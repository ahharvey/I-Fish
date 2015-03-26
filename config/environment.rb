# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
IFish::Application.initialize!

Time::DATE_FORMATS[:triptime] = "%H:%M (%b-%d)"
Time::DATE_FORMATS[:sdate] = "%d-%b-%Y"