defmodule NutritionCalculator.Person do
  @moduledoc """
  A person construct with related validations. At this moment it does not
  support any type of weight or height conversions, everything is assumend to be
  in metric system.
  """

  @type gender :: :male | :female
  @type weight :: {:kg, number()} | {:lbs, number()}
  @type height :: {:cm, number()} | {:ft, integer(), :in, integer()}
  @type age :: integer()

  defstruct gender: nil, weight: nil, height: nil, age: nil
  @type t :: %NutritionCalculator.Person{
    gender: gender, weight: weight, height: height
  }

  @spec validate_person(%NutritionCalculator.Person{}) :: boolean
  def validate_person(person) do
    validate_gender(person) && validate_age(person) && validate_weight(person)
  end

  @spec validate_gender(%NutritionCalculator.Person{}) :: boolean
  def validate_gender(person) do
    genders = [:male, :female]
    Enum.member?(genders, person.gender)
  end

  @spec validate_age(%NutritionCalculator.Person{}) :: boolean
  def validate_age(person) do
    is_positive_integer?(person.age)
  end

  @spec validate_weight(%NutritionCalculator.Person{}) :: boolean
  def validate_weight(person) do
    is_positive_number?(person.weight)
  end

  @spec is_positive_number?(any()) :: boolean
  defp is_positive_number?(number) do
    case number do
      x when is_number(x) and x >= 0 ->
        true
      _ ->
        false
    end
  end

  @spec is_positive_integer?(any()) :: boolean
  defp is_positive_integer?(number) do
    case number do
      x when is_integer(x) and x >= 0 ->
        true
      _ ->
        false
    end
  end
end
