defmodule NutritionCalculator.Weight do
  @moduledoc """
  Functions and types to perform weight-related operations
  """

  @type weight :: {:kg, number()} | {:lbs, number()}

  @doc """
  Assume kilograms if no weight unit is provided.
  """
  @spec create_weight(number()) :: weight
  def create_weight(value) when is_number(value) do
    {:kg, value}
  end

  @doc """
  Throw error when weight is not a number
  """
  def create_weight(_value) do
    raise(ArgumentError, message: "Value must be a number")
  end

  @spec create_weight(number(), :kg | :lbs) :: weight
  def create_weight(value, unit)
  when (unit == :kg or unit == :lbs) and is_number(value) do
    {unit, value}
  end

  def create_weight(_value, _unit) do
    raise(ArgumentError, message: "Unknown value type")
  end
end
