defmodule NutritionCalculator.Person do
  alias Person.Weight
  alias Person.Height

  alias NutritionCalculator.Person

  @moduledoc """
  A person construct with related validations. At this moment it does not
  support any type of weight or height conversions, everything is assumend to be
  in metric system.
  """

  @type gender :: :male | :female
  @type age :: integer()
  @type system :: :imperial | :metric

  @type map_person :: %{weight: number(), height: number(), system: system,
                        age: number(), gender: gender}

  defstruct gender: nil, weight: nil, height: nil, age: nil, system: nil
  @type t :: %NutritionCalculator.Person{
    gender: gender, weight: Weight.t, height: Height.t, system: system()
  }

  @spec create_person(map_person) :: Person.t
  def create_person(person = %{}) do
    {weight, height} =
      case person.system do
        :imperial ->
          {Weight.create_weight(person.weight, :lbs),
           Height.create_height(person.height, :imperial)}
        :metric ->
          {Weight.create_weight(person.weight, :kg),
           Height.create_height(person.height, :metric)}
      end

    %Person{weight: weight, height: height, age: person.age,
            gender: person.gender, system: person.system}
  end

  @spec validate_person(%NutritionCalculator.Person{}) :: boolean
  def validate_person(person = %Person{}) do
    validate_gender(person)
    && validate_age(person)
    && validate_weight(person)
    && validate_height(person)
    && validate_system(person)
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
  def validate_weight(person = %Person{}) do
    person.weight != nil
  end

  def validate_weight(_person) do
    false
  end

  @spec validate_system(%NutritionCalculator.Person{}) :: boolean
  def validate_system(person = %Person{}) do
    case person.system do
      :metric ->
        true
      :imperial ->
        true
      _ ->
        false
    end
  end

  @spec validate_height(%NutritionCalculator.Person{}) :: boolean
  def validate_height(person = %Person{}) do
    person.height != nil
  end

  def validate_height(_person) do
    false
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
