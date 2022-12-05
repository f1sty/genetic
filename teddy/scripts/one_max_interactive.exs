defmodule OneMaxInteractive do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
    genes = for _ <- 1..500, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 500}
  end

  @impl true
  def fitness_function(chromosome) do
    IO.inspect(chromosome)

    IO.gets("Rate from 1 to 10 ")
    |> String.trim()
    |> String.to_integer()
  end

  @impl true
  def terminate?([_best | _], _generation, temperature) do
    # best.fitness == 500
    temperature < 25
  end
end

solution = Teddy.run(OneMaxInteractive)
IO.write("\n")
IO.inspect(solution)
