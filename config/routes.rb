ExportXls::Application.routes.draw do

  devise_for :admins
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  resources :gears
  resources :fish
  resources :offices

  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home#import_mail'
  root :to => 'home#index'
end
