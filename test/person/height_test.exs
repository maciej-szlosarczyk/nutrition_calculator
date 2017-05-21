defmodule HeightTest do
  use ExUnit.Case, async: true

  alias Person.Height

  doctest Person.Height

  describe "create_height/1" do
    test "return metric value with numeric argument" do
      height = Height.create_height(181)

      assert height == %Height{unit: :metric, value: 181}
    end

    test "raise argument error when value < 0" do
      assert_raise ArgumentError, fn ->
        Height.create_height(-12)
      end
    end
  end

  describe "create_height/2" do
    test "return metric value with :metric" do
      height = Height.create_height(181, :metric)

      assert height == %Height{unit: :metric, value: 181}
    end

    test "return imperial value with :imperial" do
      height = Height.create_height(181, :imperial)

      assert height == %Height{unit: :imperial, value: 181}
    end

    test "raise argument error with negative number" do
      assert_raise ArgumentError, fn ->
        Height.create_height(-122, :metric)
      end
    end

    test "raise argument error with unknown unit" do
      assert_raise ArgumentError, fn ->
        Height.create_height(122, :atom)
      end
    end
  end

  describe "convert_height/2" do
    test "returns imperial values with :imperial" do
      height = Height.create_height(181, :metric)
      converted_height = %Height{unit: :imperial, value: 71}

      assert Height.convert_height(height, :imperial) == converted_height
    end

    test "returns the same value if the value is already :imperial" do
      height = Height.create_height(71, :imperial)

      assert Height.convert_height(height, :imperial) == height
    end

    test "returns metric values with :metric" do
      height = Height.create_height(71, :imperial)
      converted_height = Height.create_height(180, :metric)

      assert Height.convert_height(height, :metric) == converted_height
    end
  end

  describe "decorate/1" do
    test "it decorates metric values" do
      height = Height.create_height(181, :metric)
      decorated_height = %{unit: :metric, meters: 1, centimeters: 81}

      assert Height.decorate(height) == decorated_height
    end

    test "it decorates imperial values" do
      height = Height.create_height(72, :imperial)
      decorated_height = %{unit: :imperial, feet: 6, inches: 0}

      assert Height.decorate(height) == decorated_height
    end
  end
end
