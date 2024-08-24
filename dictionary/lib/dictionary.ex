defmodule Dictionary do
  def word_list do
    _ = File.read!("assets/words.txt")
        |> String.split(~r/\n/, trim: true)
  end

  def random_word do
    Enum.random(Dictionary.word_list)
  end
end
