Rails.application.routes.draw do
  get "/articles", to: "articles#index"
  
  root "articles#index"
end
