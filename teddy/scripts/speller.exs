defmodule Speller do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
    genes =
      Stream.repeatedly(fn -> Enum.random(?a..?z) end)
      |> Enum.take(34)

    %Chromosome{genes: genes, size: 34}
  end

  @impl true
  def fitness_function(chromosome) do
    target = "supercalifragilisticexpialidocious"
    guess = List.to_string(chromosome.genes)
    String.jaro_distance(target, guess)
  end

  @impl true
  def terminate?([_best | _], _generation, temperature) do
    # best.fitness == 1
    # generation == 10000
    temperature < 0.00005
  end
end

solution = Teddy.run(Speller)
IO.write("\n")
IO.inspect(solution)
