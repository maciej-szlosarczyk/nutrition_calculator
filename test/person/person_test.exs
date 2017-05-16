defmodule PersonTest do
  use ExUnit.Case, async: true

  alias NutritionCalculator.Person

  doctest NutritionCalculator.Person

  test "assert gender inclusion" do
    john = %Person{gender: :male}
    mary = %Person{gender: :giant_robot}

    assert Person.validate_gender(john) == true
    assert Person.validate_gender(mary) == false
  end

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

  test "assert numeric weight" do
    john = %Person{weight: "Big scary tree"}
    mary = %Person{weight: 12}

    assert Person.validate_weight(john) == false
    assert Person.validate_weight(mary) == true
  end

  test "assert positive weight" do
    john = %Person{weight: -11}
    mary = %Person{weight: 12.12}

    assert Person.validate_weight(john) == false
    assert Person.validate_weight(mary) == true
  end

  test "assert general validation" do
    john = %Person{weight: 12, height: 12, age: 12, gender: :male}
    mary = %Person{weight: 0.112, height: 1.112, age: -12, gender: :robot}

    assert Person.validate_person(john) == true
    assert Person.validate_person(mary) == false
  end
end
