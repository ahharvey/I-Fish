ExportXls::Application.routes.draw do

  resources :catches
  resources :landings
  resources :desas
  resources :surveys
  resources :gears
  resources :fish

  devise_for :users
  
  get 'home/upload_data'
  post 'home/process_upload_data'
  root :to => 'home#index'
end
