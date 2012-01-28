CapellaJuris::Application.routes.draw do
  root :to => 'home#index'

  get 'login', :to => "sessions#new"
  post 'login', :to => "sessions#create"
  delete 'logout', :to => "sessions#destroy"

  get '', :to => "home#index", :as => :home
  resources :news do
    post 'preview', :on => :collection
  end

  get 'o_nama', :to => "about_us#index", :as => :about_us
  resources :activities do
    post 'preview'
  end
  resources :members

  get 'slike', :to => "photos#index", :as => :gallery
  get 'video', :to => "videos#index", :as => :videos
  resources :videos, :only => [:new, :create, :destroy]
end
