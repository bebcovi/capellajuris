CapellaJuris::Application.routes.draw do
  root :to => "pages#index"

  get "login", :to => "sessions#new"
  post "login", :to => "sessions#create"
  delete "logout", :to => "sessions#destroy"

  get "", :to => "pages#index", :as => :home
  get "o_nama", :to => "pages#about_us", :as => :about_us
  get "slike", :to => "pages#gallery", :as => :gallery
  get "video", :to => "pages#videos", :as => :videos
  get "arhiva", :to => "pages#archive", :as => :archive

  resources(:news) { post "preview", :on => :collection }
  resource :sidebar
  resources :audios
  resources(:general_contents) { post "preview", :on => :collection }
  resources(:activities) { post "preview", :on => :collection }
  resources(:members) { get "edit", :to => "members#gui", :on => :collection }
  resources :videos
end
