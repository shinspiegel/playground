defmodule Rocketpay.Users.Create do
  def call(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:create_user, Rocketpay.User.changeset(params))
    |> Ecto.Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Ecto.Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Rocketpay.Repo.transaction(multi) do
      {:error, _operation, reason, _change} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}
    Rocketpay.Account.changeset(params)
  end
end
