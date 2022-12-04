defmodule OneMax do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
    genes = for _ <- 1..500, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 500}
  end

  @impl true
  def fitness_function(chromosome) do
    Enum.sum(chromosome.genes)
  end

  @impl true
  def terminate?([best | _]) do
    best.fitness == 500
  end
end

solution = Teddy.run(OneMax)
IO.write("\n")
IO.inspect(solution)
