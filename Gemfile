source 'https://rubygems.org'
ruby "2.2.0"

##
## STACK
gem 'rails', '~> 4.2.0' #3.2.11'
gem 'pg', '~> 0.18.0'
#gem 'unicorn', '~> 4.8.0'
gem 'puma', '~> 2.11.0' 
gem 'rack-timeout', '~> 0.2.0'
gem 'hirefire-resource', '~> 0.3.5'

## 
## MODELS
gem 'paper_trail', '~> 4.0.0'
#gem 'queue_classic', '~>2.1.2' #queued processes
gem 'sidekiq', '~> 3.4.0'
gem 'validates_timeliness', '~> 3.0.0'
gem 'chronic', '~> 0.10.2'

##
## CONTROLLERS
# gem 'inherited_resources', '~> 1.6.0'
gem 'responders', '2.1.0'

##
## AUTHENTICATION
gem 'devise', '~> 3.5.0'
gem 'devise_invitable', '~> 1.5.0'                  
gem 'cancancan', '~> 1.12.0'
gem 'omniauth', '~> 1.2.0'
gem 'doorkeeper', '~> 3.0.0'
#gem 'oauth2'

##
## INCLUDES
gem 'jquery-rails', '~> 4.0.0'
gem 'jquery-ui-rails', '~> 5.0.0'
gem 'sass-rails',   '~> 5.0.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '~> 2.7.0'


##
## CSS AND STYLING
gem 'bootstrap-sass', '~> 3.3.0'                
gem 'font-awesome-sass', '~> 4.3.0'
gem 'simple_form', '~> 3.1.0'
gem 'kaminari', '~> 0.16.0'
gem 'rails4-autocomplete', '~> 1.1.1'
# gem 'bootstrap-switch-rails', '~> 1.8.1' #toggle buttons for Twitter Bootsterap

##
## UI
gem 'best_in_place', '~> 3.0.0' #in-line editing for logbooks and surveys
gem 'gmaps4rails', '~> 2.1.0'       
gem 'local_time', '~> 1.0.0'
gem 'country_select', '~> 2.2.0'
gem 'countries', '~> 0.11.0'
gem 'modernizr-rails', '~> 2.7.0'
gem 'groupdate', '~> 2.4.0' # formats data for charts
gem 'chartkick', '~> 1.3.2' # adds ChartKick
#gem 'jquery-datatables-rails', '~> 1.12.1'

##
## DOWNLOADS AND OUTGOING
# gem 'wicked_pdf', '~> 0.11.0'
# gem 'wkhtmltopdf-heroku', '~> 2.12.0'
gem 'rabl', '~> 0.11.0' # JSON templates
gem 'oj', '~> 2.12.0' #high performance JSON parser for rabl
gem 'unf', '~> 0.1.3' #Unicode support required by Fog
gem 'rqrcode-with-patches', '~>0.6.0'
gem 'prawn', '~> 2.0.1'
#gem 'prawn-labels', '~> 1.2.3'
gem 'prawn-qrcode', '~> 0.2.2.1'

##
## UPLOADS AND INCOMING
gem 'carrierwave', '~> 0.10.0'
gem 'carrierwave_direct', '~> 0.0.15'
gem 'fog', '~> 1.31.0'
gem 'roo', '~> 2.0.0'
gem 'roo-xls', '~> 1.0.0'
gem 'mini_magick', '~> 4.2.0'
gem 'rmagick', '~> 2.15.0'
gem 'griddler', '~> 1.2.0'  #Mandril API for incoming email handling
gem 'griddler-mandrill', '~> 1.1.0'
gem 'rubyzip', '~> 1.1.0'
# gem 'zip-zip', '~> 0.2'




gem 'sinatra', require: nil


# gem 'axlsx_rails', '~> 0.2.0'
#gem 'rinruby', '~> 2.0.3'



  


group :development do
  # Debugging
  #gem 'pry'
  #gem 'pry-debugger'
  #gem 'pry-stack_explorer'
  # gem 'debugger'
  gem 'byebug'

  gem 'annotate'
  gem 'hirb'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'letter_opener'
  # gem 'rack-mini-profiler', '~> 0.1.31'
end

group :production, :staging do
  gem 'rails_12factor'
end


gem 'newrelic_rpm', '~> 3.13.0' #system monitoring and profiling

