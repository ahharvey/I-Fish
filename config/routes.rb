require 'sidekiq/web'

IFish::Application.routes.draw do

  use_doorkeeper
  mount_griddler
  


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
        sessions: 'admins/sessions',
        passwords: 'admins/passwords'
      },
      path_names: {  
        sign_in: 'signin',
        sign_out: 'signout',
        registration: 'account',
        sign_up: 'signup'
      }

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

    namespace :staff do
      resources :dashboard
    end

    resources :catches
    resources :desas do
      resources :surveys
    end
    resources :fisheries do
      resources :companies, only: [:create, :new]
      resources :gears, only: [:create, :new]
      resources :fishes, only: [:create, :new]
      resources :offices, only: [:create, :new]
      member do
        get :report
        post :add_target_fish
        delete :delete_target_fish
        post :add_bait_fish
        delete :delete_bait_fish
        post :add_used_gear
        delete :delete_used_gear
        post :add_member_company
        post :create_member_company
        get :new_member_company
        delete :delete_member_company
        post :add_member_office
        delete :delete_member_office
      end
    end
    resources :fishes do
      collection do
        post :import
        get :autocomplete
      end
    end
    resources :gears
    resources :landings
    resources :offices do
      member do
        post :add_admin
        delete :delete_admin
      end
    end
    resources :surveys do
      member do
        put :approve
        put :pend
        put :reject
      end
    end
    resources :audits, except: [:edit] do
      resources :pending_vessels, only: [:new, :create]
    end
    resources :engines
    resources :graticules
    resources :vessel_types
    resources :districts
    resources :provinces
    resources :logbooks do
      put :approve, on: :member
      put :pend, on: :member
      put :reject, on: :member
    end
    resources :logged_days
    resources :excel_files
    resources :activities

    resources :responders

    resources :tests

    resources :vessels do
      resources :unloadings
      resources :bait_loadings
      resources :carrier_loadings
      resources :audits, except: [:edit]
      collection do
        get :generate_stickers
      end
    end
    resources :pending_vessels do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :vessel_imports do
      collection do
        get :template
      end
    end
    
    resources :unloadings do 
      member do
        put :approve
        put :pend
        put :reject
      end
    end
    resources :unloading_catches
    resources :carrier_loadings
    resources :size_classes
    
    resources :companies do
      resources :unloadings
      resources :bait_loadings
      resources :carrier_loadings
      resources :vessels
      resources :audits, except: [:edit]
      member do
        get 'crop' => 'companies#crop', :as => :crop
        get :report
        post :add_vessel
        delete :delete_vessel
        get 'report'
        get :average_catch_composition
        get :current_catch_composition
        get :current_monthly_production
        get :average_monthly_production
        get :current_fuel_utilization
        post :add_user
        delete :delete_user
      end
    end

    resources :bait_loadings do
      member do
        put :approve
        put :pend
        put :reject
      end
    end
    resources :baits

    resources :documents

    resources :protocols

    resources :users, :only => [:index, :show, :edit, :update] do
      member do
        get 'welcome' => 'users#welcome', :as => :welcome
        get :report
        get :crop
      end
    end
    resources :admins, :only => [:index, :show, :edit, :update] do
      member do
        get :welcome
        get :crop
      end
    end


    namespace :api, defaults: {format: 'json'} do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
        # resources :users
        # resources :admins
        # resources :logbooks
        # resources :surveys
        resources :fisheries
        # resources :desas, path: :landing_sites
        # resources :districts
        # resources :provinces
        # resources :engines
        # resources :gears
        resources :fishes
        resources :vessels, only: [:index]
      end
    end

    


    get 'home/index'
    get 'home/upload_data'
    get '/reports' => 'home#reports' 
    get '/user_profile' => 'home#user_profile'
    get '/fishery_profile' => 'home#fishery_profile'
    get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"


    match '/multipart_import' => 'home#multipart_import', via: [:get, :post]
    post '/import_mail' => 'home#import_mail'

    post 'home/process_upload_data'

    #authenticate :admin, lambda { |a| a.admin? } do
      
    #end
    authenticated :admin do
      root :to => "home#index", as: :admin_root
      mount Sidekiq::Web => '/sidekiq'
    end

    authenticated :user do
      root to: 'users#home', as: :user_root
    end
    # handles /valid-locale
    root to: 'home#index'
    # handles /valid-locale/fake-path
    #match '*path', to: redirect { |params, request| "/#{params[:locale]}" }

  end

  

 

  # handles /bad-locale|anything/valid-path
  match '/*locale/*path', to: redirect("/#{I18n.default_locale}/%{path}"), via: :get
  
  # handles /anything|valid-path-but-no-locale
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }, via: :get

  # handles /
  #root to: redirect("/#{I18n.default_locale}")
  match '', to: redirect("/#{I18n.default_locale}"), via: :get

  

end
