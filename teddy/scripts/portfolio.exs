defmodule Portfolio do
  @behaviour Problem
  alias Types.Chromosome

  @target_fitness 180

  def genotype() do
    genes = for _ <- 1..10, do: {:rand.uniform(10), :rand.uniform(10)}
    %Chromosome{genes: genes, size: 10}
  end

  def fitness_function(chromosome) do
    Enum.reduce(chromosome.genes, 0, fn {roi, risk}, acc -> acc + (2 * roi - risk) end)
  end

  def terminate?([best | _], _generation, _temperature) do
    best.fitness > @target_fitness
  end
end

solution = Teddy.run(Portfolio)
IO.write("\n")
IO.inspect(solution)
