defmodule NutritionCalculator.Formula do
  alias Person.Weight
  alias Person.Height

  alias NutritionCalculator.Person

  @moduledoc """
  Functions to calucate various formulas related to nutrition
  """

  @doc """
  Calculate Body Mass Index for a given person.

  NB! Thread carefully, BMI is not known to be very reliable measure of true
  body composition, especially for people who lift weight.
  """
  @spec bmi(%Person{system: :metric}) :: float()
  def bmi(person = %Person{system: :metric}) do
    {weight, height} = {person.weight.value, person.height.value}
    bmi_calculation({weight, height})
  end

  @spec bmi(%Person{system: :imperial}) :: float()
  def bmi(person = %Person{system: :imperial}) do
    {weight, height} = {Weight.convert_weight(person.weight, :kg),
                        Height.convert_height(person.height, :metric)}
    bmi_calculation({weight.value, height.value})
  end

  @spec bmi_calculation({float(), float()}) :: float()
  defp bmi_calculation({weight, height}) do
    height_pow = :math.pow((height / 100), 2)
    weight
    |> (fn(x) -> x / height_pow end).()
    |> Float.round(2)
  end
end
