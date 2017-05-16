defmodule WeightTest do
  use ExUnit.Case, async: true

  alias NutritionCalculator.Weight

  doctest NutritionCalculator.Weight

  describe "create_weight/1" do
    test "with numeric argument" do
      weight = Weight.create_weight(12)

      assert weight == {:kg, 12}
    end
  end
  defmodule WeightTest do
    use ExUnit.Case, async: true

    alias NutritionCalculator.Weight

    doctest NutritionCalculator.Weight

    describe "create_weight/1" do
      test "return value with numeric argument" do
        weight = Weight.create_weight(12)

        assert weight == {:kg, 12}
      end

      test "raise error with any other argument" do
        assert_raise ArgumentError, fn ->
          Weight.create_weight(:atom)
        end
      end
    end

    describe "create_weight/2" do
      test "return appropriate value with :kg or :lbs" do
        weight = Weight.create_weight(12, :kg)

        assert weight == {:kg, 12}
      end

      test "raise error with other type of argument" do
        assert_raise ArgumentError, fn ->
          Weight.create_weight(12, :atom)
        end

        assert_raise ArgumentError, fn ->
          Weight.create_weight("Not a number", :kg)
        end
      end
    end
  end
end
