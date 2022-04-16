defmodule Cards do
  @moduledoc """
  Provider methods for provind and creating decks of cards
  """

  @doc """
  Return a list of string that will represent the deck of cards

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Enum.count(deck)
      52

  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearst", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Will take an arrays of string cards and return the same amount of cards but in a shuffed order

  ## Examples

      iex> deck = Cards.create_deck()
      iex> deck = Cards.shuffle(deck)
      iex> Enum.count(deck)
      52

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Will verify if there is a specific card string on the deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Invalid Card")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Will take and deck and split into the hand, by the `hand_size` and the remaining of the deck

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exists"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
