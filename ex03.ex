Code.compiler_options(ignore_module_conflict: true)

defmodule Ex03 do
  require Integer

  ##############################################################################
  # 3: 4 questions,  20 points available                                       #
  ##############################################################################
  # Rubric (per question):                                                     #
  #                                                                            #
  # Does it pass tests?. . . . . . . . . . . . . . . . 60%                     #
  #                                                                            #
  # Was is written using the given constraints? Is . . 20%                     #
  # it free of any errors not found by the tests                               #
  #                                                                            #
  #                                                                            #
  # Is it written in a functional, Elixir style? . . . 20%                     #
  ##############################################################################

  @moduledoc """

  All the exercises in this module should be solved using _named
  functions_ (`def fname...`).

  The `iex` sessions in the documentation block for each shows samples
  of how the function should be used.

  Remember you can load this code in `iex` from the command line and
  play with it using:

      $ iex ex03.ex

  You can run tests using:

      $ elixir ex03.ex

  Use no library functions unless explicitly noted.
  """

  ##############################################################################
  # 3.1:  5 points #
  ##################

  @doc """

  Write a function (or functions) that take a list of integers and
  generates a new list of atoms, where the output list contains `:odd`
  is the corresponding integer is odd, `:even` otherwise.

      iex> Ex03.odd_even [ 1, 2, 4, 7, 9 ]
      [ :odd, :even, :even, :odd, :odd ]

  (The library functions `Integer.is_even` and `Integer.is_odd` may
  be used if needed.)

  """

  def odd_even(numbers) do
    Enum.map(numbers, &(if Integer.is_even(&1), do: :even, else: :odd))
  end


  ##############################################################################
  # 3.2:  5 points #
  ##################

  @doc """
  Write a function that returns true if a list contains a
  given value, false otherwise.

      iex> Ex03.list_contains([ 1, 2, 3, 4], 3)
      true

      iex> Ex03.list_contains([ 1, 2, 3, 4], 3)
      true

      iex> Ex03.list_contains([ 1, 2, 3, 4], 3)
      true

  """

  def list_contains(list, value) do
    Enum.member?(list, value)
  end

  ##############################################################################
  # 3.3:  5 points #
  ##################

  @doc """
  Two lists are equal if they contain the same number of elements,
  and each element in one equals the corresponding element in
  the other. Normally you use the operator `==` to test for this.

  However, let's assume that `==` doesn't work for lists. Write
  a function that checks for the equality of two lists. You don't
  need to consider nested lists.

      iex> Ex03.list_equal [ 1, 2, 3 ], [1, 2, 3]
      true
      iex> Ex03.list_equal [ 1, 2, 3 ], [1, 2, 3, 4]
      false
      iex> Ex03.list_equal [ 1, 2, 3 ], [3, 2, 1]
      false

  """

  def list_equal(list1, list2) do
    if length(list1) == length(list2) do
      Enum.zip(list1, list2)
      |> Enum.reduce_while(true, &(if !&2, do: {:halt, &2}, else: {:cont, elem(&1, 0) == elem(&1, 1)}))
    else
      false
    end
  end



  ##############################################################################
  # 3.4:  5 points #
  ##################

  @doc """
  Inspired by recent computer wins in the game of Go, your team
  decides to push the boundaries of technology by implementing
  a noughts-and-crosses playing program.

  The team has decided to represent the board as a 9 element
  tuple:

       0 | 1 | 2
       --+---+--
       3 | 4 | 5      => { 1, 2, 3,  4, 5, 6,  7, 8, 9 }
       --+---+--
       6 | 7 | 8

  Each element of the tuple is set to :x or :o if the corresponding
  player has occupied the square, or its number otherwise.


       X | X |
       --+---+--
         | O |        => { :x, :x, 3,   4, :o, 6,   7, :o, :x }
       --+---+--
         | O | X

  There are eight winning positions (three horizontal, three vertical,
  and two diagonal). Write a function that returns :x if X has won, :o
  if O has won, and false otherwise.

      iex> Ex03.won { :x, :o, 3,   :x, 5, :o,   :x, 8, :o }
      :x

      iex> Ex03.won { :o, :x, 3,   :x, :o, 6,   :x, 5, :o }
      :o

      iex> Ex03.won { :o, :x, 3,   :x, :o, 6,   :x, :o, 9 }
      false

  Think a little about a nice way to lay this code out.
  """

  def won(board) do
    {e00, e10, e20, e01, e11, e21, e02, e12, e22} = board
    winner = false

    # horizontal cases
    winner = if list_equal(List.duplicate(e00, 3), [e00, e10, e20]), do: e00, else: winner
    winner = if list_equal(List.duplicate(e01, 3), [e01, e11, e21]), do: e01, else: winner
    winner = if list_equal(List.duplicate(e02, 3), [e02, e12, e22]), do: e02, else: winner

    # vertical cases
    winner = if list_equal(List.duplicate(e00, 3), [e00, e01, e02]), do: e00, else: winner
    winner = if list_equal(List.duplicate(e10, 3), [e10, e11, e12]), do: e10, else: winner
    winner = if list_equal(List.duplicate(e20, 3), [e20, e21, e22]), do: e20, else: winner

    # diagonal cases
    winner = if list_equal(List.duplicate(e00, 3), [e00, e11, e22]), do: e00, else: winner
    winner = if list_equal(List.duplicate(e20, 3), [e20, e11, e02]), do: e20, else: winner

    if winner == :x || winner == :o, do: winner, else: false
  end


  ###########################
  # IGNORE FROM HERE TO END #
  ###########################

  @after_compile __MODULE__

  def __after_compile__(_env, bytecode) do
    File.write("Elixir.Ex03.beam", bytecode)
  end

end


ExUnit.start
defmodule TestEx03 do
  use ExUnit.Case
  doctest Ex03
end
