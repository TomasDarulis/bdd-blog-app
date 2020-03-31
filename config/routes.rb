Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  
  #gives all the needed routes (7 routes)
  resources :articles
end
