defmodule Teddy do
  def run(fitness_function, genotype, max_fitness, opts \\ []) do
    genotype
    |> initialize(opts)
    |> evolve(max_fitness, fitness_function, opts)
  end

  def evolve(population, max_fitness, fitness_function, opts \\ []) do
    population = evaluate(population, fitness_function, opts)
    best = hd(population)

    IO.write("\rCurrent best: #{fitness_function.(best)}")

    if fitness_function.(best) == max_fitness do
      best
    else
      population
      |> select(opts)
      |> crossover(opts)
      |> mutation(opts)
      |> evolve(max_fitness, fitness_function, opts)
    end
  end

  def initialize(genotype, opts \\ []) do
    population_size = Keyword.get(opts, :population_size, 100)
    for _ <- 1..population_size, do: genotype.()
  end

  def evaluate(population, fitness_function, opts \\ []) do
    Enum.sort_by(population, fitness_function, &>=/2)
  end

  def select(population, opts \\ []) do
    population
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
  end

  def crossover(population, opts \\ []) do
    Enum.reduce(population, [], fn {p1, p2}, acc ->
      cx_point = :rand.uniform(length(p1))
      {{h1, t1}, {h2, t2}} = {Enum.split(p1, cx_point), Enum.split(p2, cx_point)}
      {c1, c2} = {h1 ++ t2, h2 ++ t1}
      [c1, c2 | acc]
    end)
  end

  def mutation(population, opts \\ []) do
    Enum.map(population, fn chromosome ->
      if :rand.uniform() < 0.05 do
        Enum.shuffle(chromosome)
      else
        chromosome
      end
    end)
  end
end