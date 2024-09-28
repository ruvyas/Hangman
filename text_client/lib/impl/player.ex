defmodule TextClient.Impl.Player do
  @type game :: Hangman.game()
  @type tally :: Hangman.tally()

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  ############ interacts ############

  def interact({_game, tally = %{game_state: :won}}) do
    IO.puts("#{tally.letters |> Enum.join()}")
    IO.puts("Congratulations. You have won!")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost...The word was: #{tally.letters |> Enum.join()}")
  end

  def interact({game, tally}) do
    IO.puts(feedback_for(tally))
    IO.puts(current_word(tally))

    Hangman.make_move(game, get_guess())
    |> interact()
  end

  ############ Feedback_fors ############
  def feedback_for(tally = %{game_state: :initializing}),
    do: IO.puts("welcome! I am thinking of a #{tally.letters |> length} letter word")

  def feedback_for(%{game_state: :good_guess}),
    do: IO.puts("Good guess 💪🏽")

  def feedback_for(%{game_state: :bad_guess}),
    do: IO.puts("Sorry the letter is not in the word... 🌊")

  def feedback_for(%{game_state: :already_used}),
    do: IO.puts("You already used that letter 😡")

  ############ current_words ############
  def current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      "  turns left:",
      tally.turns_left |> to_string(),
      "  used so far: ",
      tally.used |> Enum.join(",")
    ]
  end

  ############ get_guess ############
  def get_guess() do
    IO.gets("Next letter:")
    |> String.trim()
    |> String.downcase()
  end
end
