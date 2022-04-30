defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Shuffle randomizes an deck" do
    deck = Cards.create_deck()
    assert deck != Cards.shuffle(deck)
  end
end
