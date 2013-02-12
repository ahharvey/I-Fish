ExportXls::Application.routes.draw do
  
  
  

  

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/  do

    
    devise_for :users,  
      path_prefix: 'session',
      controllers: { 
        registrations: 'users/registrations'
      },
      path_names: {  
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'security',
        sign_up: 'sign_up'
      }

    devise_for :admins,  
      path_prefix: 'session',
      controllers: { 
        registrations: 'admins/registrations'
      },
      path_names: {  
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'security',
        sign_up: 'sign_up'
      }

    devise_scope :user do
      match 'user_crops' => 'user_registrations#crop', :as => :user_crop
    end

    devise_scope :admin do
      match 'admin_crops' => 'admin_registrations#crop', :as => :admin_crop 
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
    post 'home/process_upload_data'
    match '/import_mail' => 'home#import_mail'
    
    get '/user_profile' => 'home#user_profile'
    get '/fishery_profile' => 'home#fishery_profile'

    # handles /valid-locale
    root to: 'home#index'
    # handles /valid-locale/fake-path
    #match '*path', to: redirect { |params, request| "/#{params[:locale]}" }

  end

  match '/multipart_import' => 'home#multipart_import'

  # handles /bad-locale|anything/valid-path
  match '/*locale/*path', to: redirect("/#{I18n.default_locale}/%{path}")
  
  # handles /anything|valid-path-but-no-locale
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }

  # handles /
  #root to: redirect("/#{I18n.default_locale}")
  #match '', to: redirect("/#{I18n.default_locale}")


end
