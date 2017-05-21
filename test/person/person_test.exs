defmodule PersonTest do
  use ExUnit.Case, async: true

  alias Person.Weight
  alias Person.Height

  # NB! This needs to be after the aliases above
  alias NutritionCalculator.Person

  doctest NutritionCalculator.Person

  describe "create_person/1" do
    test "it creates a person" do
      map = %{weight: 80, height: 181, gender: :male, system: :metric, age: 28}

      person = %NutritionCalculator.Person{
        weight: %Weight{unit: :kg, value: 80},
        height: %Height{unit: :metric, value: 181},
        gender: :male, age: 28}

      assert Person.create_person(map) == person
    end

    test "it raises KeyError when map is incorrect" do
      assert_raise KeyError, fn ->
        Person.create_person(%{person: :person})
      end
    end
  end

  describe "validate_gender/1" do
    test "assert gender inclusion" do
      john = %Person{gender: :male}
      mary = %Person{gender: :giant_robot}

      assert Person.validate_gender(john) == true
      assert Person.validate_gender(mary) == false
    end
  end

  describe "validate_age/1" do
    test "assert numeric age" do
      john = %Person{age: "Big scary tree"}
      mary = %Person{age: 12}

      assert Person.validate_age(john) == false
      assert Person.validate_age(mary) == true
    end

    test "assert positive numeric age" do
      john = %Person{age: -18}
      mary = %Person{age: 12}

      assert Person.validate_age(john) == false
      assert Person.validate_age(mary) == true
    end

    test "assert integer age" do
      john = %Person{age: 18.02}
      mary = %Person{age: 12}

      assert Person.validate_age(john) == false
      assert Person.validate_age(mary) == true
    end
  end

  describe "validate_person" do
    test "assert general validation" do
      map = %{weight: 12, height: 12, age: 12, gender: :male, system: :metric}
      john = Person.create_person(map)
      mary = %Person{weight: 0.112, height: 1.112, age: -12, gender: :robot}

      assert Person.validate_person(john) == true
      assert Person.validate_person(mary) == false
    end
  end
end
