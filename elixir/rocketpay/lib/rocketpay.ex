defmodule Rocketpay do
  defdelegate create_user(params), to: Rocketpay.Users.Create, as: :call

  defdelegate deposit(params), to: Rocketpay.Account.Deposit, as: :call
  defdelegate withdraw(params), to: Rocketpay.Account.Withdraw, as: :call
end
