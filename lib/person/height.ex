defmodule Person.Height do
  @moduledoc """
  Functions to perform height-related operations
  """

  alias Person.Height

  defstruct unit: nil, value: nil
  @type t :: %Person.Height{
    unit: :metric | :imperial, value: number()
  }

  @doc """
  Assume metric system if no unit is given.
  """
  @spec create_height(number()) :: Height.t
  def create_height(value) when is_number(value) and value >= 0 do
    %Height{unit: :metric, value: value}
  end

  def create_height(_value) do
    raise(ArgumentError, message: "Value must be a positive number")
  end

  @spec create_height(number(), :metric | :imperial) :: Height.t
  def create_height(value, unit)
  when is_number(value) and value >= 0
  and (unit == :metric or unit == :imperial) do
    %Height{unit: unit, value: value}
  end

  def create_height(_value, _unit) do
    raise(ArgumentError, message: "Unknown or unsupported value type")
  end
end
