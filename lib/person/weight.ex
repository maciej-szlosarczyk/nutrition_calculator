defmodule Person.Weight do
  @moduledoc """
  Functions to perform weight-related operations
  """

  alias Person.Weight

  @lbs 2.20462

  defstruct unit: nil, value: nil
  @type t :: %Person.Weight{
    unit: :lbs | :kg, value: number()
  }

  @doc """
  Assume kilograms if no weight unit is provided.
  """
  @spec create_weight(number()) :: Weight.t
  def create_weight(value) when is_number(value) and value >= 0 do
    %Weight{unit: :kg, value: value}
  end

  @doc """
  Throw error when weight is not a number
  """
  def create_weight(_value) do
    raise(ArgumentError, message: "Value must be a positive number")
  end

  @spec create_weight(number(), :kg | :lbs) :: Weight.t
  def create_weight(value, unit)
  when (unit == :kg or unit == :lbs) and is_number(value) and value >= 0 do
    %Weight{unit: unit, value: value}
  end

  def create_weight(_value, _unit) do
    raise(ArgumentError, message: "Unknown value type")
  end

  @spec convert_weight(Weight.t, :kg) :: Weight.t
  def convert_weight(weight, :kg) do
    case weight.unit do
      :kg ->
        weight
      :lbs ->
        weight.value
        |> (fn(x) -> x / @lbs end).()
        |> create_weight(:kg)
    end
  end

  @spec convert_weight(Weight.t, :lbs) :: Weight.t
  def convert_weight(weight, :lbs) do
    case weight.unit do
      :lbs ->
        weight
      :kg ->
        weight.value
        |> (fn(x) -> x * @lbs end).()
        |> create_weight(:lbs)
    end
  end

  @doc """
  Throw an error when arguments do not fit the function.
  """
  def convert_weight(_weight, _measure) do
    raise(ArgumentError, message: "Wrong types for conversion")
  end
end
