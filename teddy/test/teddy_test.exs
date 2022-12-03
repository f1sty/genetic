defmodule TeddyTest do
  use ExUnit.Case
  doctest Teddy

  test "greets the world" do
    assert Teddy.hello() == :world
  end
end
