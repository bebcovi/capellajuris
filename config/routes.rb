CapellaJuris::Application.routes.draw do
  root :to => 'home#index'

  get '', :to => "home#index", :as => :home
  resources :news

  get 'login', :to => "sessions#new"
  post 'login', :to => "sessions#create"
  delete 'logout', :to => "sessions#destroy"

    post 'preview', :on => :collection
  get 'o_nama', :to => "about_us#index", :as => :about_us
    post 'preview'
  get 'slike', :to => "photos#index", :as => :gallery
  get 'video', :to => "videos#index", :as => :videos
  resources :videos, :only => [:new, :create, :destroy]
end
