defmodule WeightTest do
  use ExUnit.Case, async: true

  alias NutritionCalculator.Weight

  doctest NutritionCalculator.Weight

  describe "create_weight/1" do
    test "return value with numeric argument" do
      weight = Weight.create_weight(12)

      assert weight == %Weight{unit: :kg, value: 12}
    end

    test "raise argument error when value < 0" do
      assert_raise ArgumentError, fn ->
        Weight.create_weight(-12)
      end
    end

    test "raise error with any other argument" do
      assert_raise ArgumentError, fn ->
        Weight.create_weight(:atom)
      end
    end
  end

  describe "create_weight/2" do
    test "return appropriate value with :kg or :lbs and a number" do
      weight = Weight.create_weight(12, :kg)

      assert weight == %Weight{unit: :kg, value: 12}
    end

    test "raise error with other type of arguments" do
      assert_raise ArgumentError, fn ->
        Weight.create_weight(12, :atom)
      end

      assert_raise ArgumentError, fn ->
        Weight.create_weight("Not a number", :kg)
      end
    end
  end

  describe "convert_weight/2" do
    test "converts from kgs to lbs" do
      weight = Weight.create_weight(100, :kg)
      converted_weight = Weight.convert_weight(weight, :lbs)

      assert converted_weight == %Weight{unit: :lbs, value: 220.462}
    end

    test "convert from lbs to kg" do
      weight = Weight.create_weight(100, :lbs)
      converted_weight = Weight.convert_weight(weight, :kg)

      assert converted_weight == %Weight{unit: :kg, value: 45.35929094356398}
    end

    test "raise error when arguments are wrong" do
      assert_raise ArgumentError, fn ->
        Weight.convert_weight(:atom, :atom)
      end

      weight = Weight.create_weight(100)

      assert_raise ArgumentError, fn ->
        Weight.convert_weight(weight, 100)
      end
    end
  end
end
