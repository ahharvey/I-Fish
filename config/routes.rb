ExportXls::Application.routes.draw do

  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  resources :gears
  resources :fish

  devise_for :users, :controllers => { :registrations => "registrations" }  
  
  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home/import_mail'
  root :to => 'home#index'
end
