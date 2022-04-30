defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  describe "sum_from_file/1" do
    test "When is correct" do
      response = Rocketpay.Numbers.sum_from_file("numbers")
      expected_response = {:error, %{message: "Failed to read"}}
      assert response == expected_response
    end

    test "When is not correct" do
      response = Rocketpay.Numbers.sum_from_file("banana")
      expected_response = {:error, %{message: "Failed to read"}}
      assert response == expected_response
    end
  end
end
