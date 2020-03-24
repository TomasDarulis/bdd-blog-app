Rails.application.routes.draw do
  root to: "articles#index"
  
  #gives all the needed routes (7 routes)
  resources :articles
end
