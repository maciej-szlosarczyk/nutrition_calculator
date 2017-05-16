defmodule NutritionCalculator.Weight do
  @moduledoc """
  Functions and types to perform weight-related operations
  """

  @lbs 2.20462

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

  @spec convert_weight(weight, :kg) :: weight
  def convert_weight(weight, :kg) do
    {:lbs, number} = weight
    {:kg, (number / @lbs)}
  end

  @spec convert_weight(weight, :lbs) :: weight
  def convert_weight(weight, :lbs) do
    {:kg, number} = weight
    {:lbs, (number * @lbs)}
  end

  @doc """
  Throw an error when arguments do not fit the function.
  """
  def convert_weight(_weight, _measure) do
    raise(ArgumentError, message: "Wrong types for conversion")
  end
end
