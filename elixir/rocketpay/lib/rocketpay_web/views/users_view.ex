defmodule RocketpayWeb.UsersView do
  def render("create.json", %{user: user}) do
    %{
      message: "User created",
      data: %{
        id: user.id,
        name: user.name,
        nickname: user.nickname,
        account: %{
          id: user.account.id,
          balance: user.account.balance
        }
      }
    }
  end
end
