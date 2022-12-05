defmodule Cargo do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype() do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 10}
  end

  @impl true
  def fitness_function(chromosome) do
    profits = [6, 5, 8, 9, 6, 7, 3, 1, 2, 6]
    weights = [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]
    weight_limit = 40

    over_limit? =
      weights
      |> Enum.zip(chromosome.genes)
      |> Enum.reduce(0, fn {w, g}, acc -> acc + w * g end)
      |> Kernel.>(weight_limit)

    if over_limit? do
      0
    else
      profits
      |> Enum.zip(chromosome.genes)
      |> Enum.reduce(0, fn {p, g}, acc -> acc + p * g end)
    end
  end

  @impl true
  def terminate?(_population, generation, _temperature) do
    generation == 1000
  end
end

solution = Teddy.run(Cargo, population_size: 50)
IO.write("\n")
IO.inspect(solution)

weights = [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]

weight =
  weights
  |> Enum.zip(solution.genes)
  |> Enum.reduce(0, fn {w, g}, acc -> acc + w * g end)

IO.write("\nWeight is: #{weight}\n")
