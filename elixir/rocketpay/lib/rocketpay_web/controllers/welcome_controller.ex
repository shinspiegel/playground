defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  def index(conn, %{"filename" => filename}) do
    filename
    |> Rocketpay.Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Rocketpay API. Here is your number #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn |> put_status(:bad_request) |> json(reason)
  end
end
