defmodule FormulaTest do
  use ExUnit.Case, async: true

  alias NutritionCalculator.Person

  alias NutritionCalculator.Formula
  doctest NutritionCalculator.Formula

  describe "bmi/1" do
    test "It calculates correct values for metric system" do
      map = %{system: :metric, gender: :male, height: 180, weight: 80, age: 30}
      john = Person.create_person(map)

      assert Formula.bmi(john) == 24.69
    end

    test "it calculates correct values for imperial system" do
      map = %{system: :imperial, gender: :female, height: 70, weight: 165,
              age: 30}
      mary = Person.create_person(map)

      assert Formula.bmi(mary) == 23.62
    end
  end
end
