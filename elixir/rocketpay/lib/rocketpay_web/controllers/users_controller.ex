defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Rocketpay.User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", user: user)
    end
  end
end
