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
end
