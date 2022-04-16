Rails.application.routes.draw do
  resources :articles, only: [:show, :index, :new, :create, :edit, :update]
end
