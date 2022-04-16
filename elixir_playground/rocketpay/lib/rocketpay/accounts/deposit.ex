defmodule Rocketpay.Account.Deposit do
  def call(params) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:acount, fn repo, _changes -> get_account(repo, params.id) end)
    |> Ecto.Multi.run(:update_balance, fn repo, %{account: account} -> update_balance(repo, account, params.value) end)
  end

  defp get_account(repo, id) do
    case repo.get(Rocketpay.Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo)
  end

  defp sum_values(%Rocketpay.Account{balance: balance}, value) do
    value
    |> Decimal.cast(value)
    |> handle_cast(balance)
  end

  defp handle_cals({:ok, value}, balance) do
    Decimal.add(value, balance)
  end

  defp handle_cals({:error, _value}, balance) do
    {:error, "Invalid deposit value"}
  end

  defp update_account({:error, _reason} = error, _repo) do
    error
  end

  defp update_account(value, repo) do
    params = %{balance: value}

    params
    |> Rocketpay.Account.changeset()
    |> repo.update()
  end
end
