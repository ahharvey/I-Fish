ExportXls::Application.routes.draw do
  
  

  

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/  do

    
    devise_for :users,  
      path_prefix: 'session',
      controllers: { 
        registrations: 'users/registrations',
        sessions: 'users/sessions'
      },
      path_names: {  
        sign_in: 'signin',
        sign_out: 'signout',
        registration: 'account',
        sign_up: 'signup'
      }

    devise_for :admins,  
      path_prefix: 'session',
      controllers: { 
        registrations: 'admins/registrations',
        sessions: 'admins/sessions'
      },
      path_names: {  
        sign_in: 'signin',
        sign_out: 'signout',
        registration: 'account',
        sign_up: 'signup'
      }

    devise_scope :user do
      match 'user/crop_avatar' => 'users/registrations#crop', :as => :user_crop
      match 'user/upload_avatar' => 'users/registrations#avatar', :as => :user_avatar
      match 'user/settings' => 'users/registrations#settings', :as => :user_settings
      match 'user/security' => 'users/registrations#security', :as => :user_security
      match 'user/welcome' => 'users/registrations#welcome', :as => :user_welcome
    end

    devise_scope :admin do
      match 'admin/crop_avatar' => 'admins/registrations#crop', :as => :admin_crop
      match 'admin/upload_avatar' => 'admins/registrations#avatar', :as => :admin_avatar
      match 'admin/settings' => 'admins/registrations#settings', :as => :admin_settings
      match 'admin/security' => 'admins/registrations#security', :as => :admin_security
      match 'admin/welcome' => 'admins/registrations#welcome', :as => :admin_welcome
    end

    namespace :panel do
      resources :users do
        member do
          post :add_role
          delete :delete_role
        end
      end
      resources :admins do
        member do
          post :add_role
          delete :delete_role
          put :set_approved
        end
      end
      resources :roles, :only=>[:index, :create, :destroy]
    end

    namespace :supervisor do
      resources :surveys
      resources :logbooks
      resources :admins
      resources :dashboard
    end

    resources :catches
    resources :desas do
      resources :surveys
    end
    resources :fisheries
    resources :fishes
    resources :gears
    resources :landings
    resources :offices
    resources :surveys do
      put :set_approved, on: :member
    end
    resources :engines
    resources :graticules
    resources :vessel_types
    resources :districts
    resources :provinces
    resources :logbooks do
      put :set_approved, on: :member
    end
    resources :logged_days
    resources :excel_files

    resources :users, :only => [:index, :show, :edit, :update]
    resources :admins, :only => [:index, :show, :edit, :update]

    get 'home/index'
    get 'home/upload_data'
    get '/reports' => 'home#reports'
    post 'home/process_upload_data'
    match '/import_mail' => 'home#import_mail'
    
    get '/user_profile' => 'home#user_profile'
    get '/fishery_profile' => 'home#fishery_profile'

    # handles /valid-locale
    root to: 'home#index'
    # handles /valid-locale/fake-path
    #match '*path', to: redirect { |params, request| "/#{params[:locale]}" }

  end

  match '/multipart_import' => 'home#multipart_import', via: [:get, :post]

  # handles /bad-locale|anything/valid-path
  match '/*locale/*path', to: redirect("/#{I18n.default_locale}/%{path}")
  
  # handles /anything|valid-path-but-no-locale
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }

  # handles /
  #root to: redirect("/#{I18n.default_locale}")
  match '', to: redirect("/#{I18n.default_locale}")


end
