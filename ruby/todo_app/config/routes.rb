Rails.application.routes.draw do
  post "/auth/register", to: "auth#register"
  post "/auth/login", to: "auth#login"
end
