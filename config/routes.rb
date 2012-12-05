ExportXls::Application.routes.draw do

  get "omenk/index"

  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  resources :gears
  resources :fish


  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    match 'crops' => 'registrations#crop', :as => :crop
  end

  get 'home/upload_data'
  post 'home/process_upload_data'
  match '/import_mail' => 'home#import_mail'
  root :to => 'home#index'
end
