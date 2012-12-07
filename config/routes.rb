ExportXls::Application.routes.draw do

  resources :gears

  resources :fishes

  resources :fisheries

  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  
  devise_for :users, :controllers => { :registrations => "registrations" }  
  
  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home#import_mail'
  match '/multipart_import' => 'home#multipart_import'
  get '/user_profile' => 'home#user_profile'
  get '/fishery_profile' => 'home#fishery_profile'
  root :to => 'home#index'
end
