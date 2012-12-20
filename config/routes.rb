ExportXls::Application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/, defaults: { locale: "en" }  do

    devise_for :admins, :controllers => { :registrations => "admin_registrations" }
    devise_for :users, :controllers => { :registrations => "user_registrations" }

    devise_scope :user do
      match 'user_crops' => 'user_registrations#crop', :as => :user_crop
    end

    devise_scope :admin do
      match 'admin_crops' => 'admin_registrations#crop', :as => :admin_crop 
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
end
