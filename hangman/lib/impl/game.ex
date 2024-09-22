defmodule Hangman.Impl.Game do
  @type t :: %__MODULE__{
      game_state: Hangman.state,
      letters: list(String.t),
      turns_left: integer,
      used: MapSet.t(String.t)
    }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @spec init_game() :: Hangman.Impl.Game.t()
  def init_game do
    %__MODULE__{
      letters: Dictionary.random_word() |> String.codepoints()
    }
  end
end
