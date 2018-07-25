defmodule ParamsValidation.EctoTypeTester do
  @behaviour Ecto.Type

  defstruct a: nil, b: nil, c: nil

  def type, do: :map

  def cast(%{} = data) do
    {:ok, %ParamsValidation.EctoTypeTester{a: data["a"] || data.a, b: data["b"] || data.b, c: data["c"] || data.c}}
  end

  def cast(_) do
    :error
  end

  def dump(_), do: :error

  def load(_), do: :error
end
