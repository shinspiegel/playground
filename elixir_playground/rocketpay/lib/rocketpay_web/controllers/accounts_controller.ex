defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Rocketpay.Accounts{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def deposit(conn, params) do
    with {:ok, %Rocketpay.Accounts{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end
end
