class AuthController < ApplicationController
  def register
    
    user = User.find_by(email: params[:email])

    if user.nil?
      return failure_code "User already existis"
    end

    user = User.create(email: params[:email], password: params[:password])

    success_code user
  end

  def login
    failure_code
  end
end
