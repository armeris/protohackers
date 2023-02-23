defmodule ProtohackersTest do
  use ExUnit.Case, async: true
  doctest Protohackers

  test "greets the world" do
    assert Protohackers.hello() == :world
  end
end
