defmodule Toolbox.Selection do
  def elite(population, n) do
    Enum.take(population, n)
  end

  def random(population, n) do
    Enum.take_random(population, n)
  end

  def tournament(population, n, tourn_size) do
    Enum.map(0..(n - 1), fn _ ->
      population
      |> Enum.take_random(tourn_size)
      |> Enum.max_by(& &1.fitness)
    end)
  end

  def tournament_no_duplicates(population, n, tourn_size) do
    selected = MapSet.new()
    tournament_helper(population, n, tourn_size, selected)
  end

  defp tournament_helper(population, n, tourn_size, selected) do
    if MapSet.size(selected) == n do
      MapSet.to_list(selected)
    else
      chosen =
        population
        |> Enum.take_random(tourn_size)
        |> Enum.max_by(& &1.fitness)

      tournament_helper(population, n, tourn_size, MapSet.put(selected, chosen))
    end
  end

  def roulette(population, n) do
    fitness_sum = Enum.reduce(population, 0, &(&1.fitness + &2))

    Enum.map(0..(n - 1), fn _ ->
      u = :rand.uniform() * fitness_sum

      Enum.reduce_while(population, 0, fn x, sum ->
        if x.fitness + sum > u do
          {:halt, x}
        else
          {:cont, sum + x.fitness}
        end
      end)
    end)
  end
end
