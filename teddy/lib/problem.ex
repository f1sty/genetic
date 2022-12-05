defmodule Problem do
  alias Types.Chromosome

  @callback genotype :: Chromosome.t()
  @callback fitness_function(Chromosome.t()) :: number()
  @callback terminate?([Chromosome.t()], integer(), number()) :: boolean()
end
