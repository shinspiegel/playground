defmodule Rocketpay.Deposit.Withdraw do
  def call(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:create_user, Rocketpay.User.changeset(params))
    |> Ecto.Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Ecto.Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end
end
