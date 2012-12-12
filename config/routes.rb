ExportXls::Application.routes.draw do


  devise_for :admins
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    match 'crops' => 'registrations#crop', :as => :crop
  end

    
  resources :catches
  resources :desas
  resources :fisheries
  resources :fishes
  resources :gears
  resources :landings  
  resources :offices
  resources :surveys

  resources :users, :only => [:index, :show]
  resources :admins, :only => [:index, :show]

  get 'home/index'
  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home#import_mail'
  match '/multipart_import' => 'home#multipart_import'
  get '/user_profile' => 'home#user_profile'
  get '/fishery_profile' => 'home#fishery_profile'
  root :to => 'home#index'
end
