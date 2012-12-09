ExportXls::Application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :fisheries
  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  resources :gears
  resources :fishes
  resources :offices
  resources :users, :only => [:index, :show]

  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home#import_mail'
  match '/multipart_import' => 'home#multipart_import'
  get '/user_profile' => 'home#user_profile'
  get '/fishery_profile' => 'home#fishery_profile'
  root :to => 'home#index'
end
