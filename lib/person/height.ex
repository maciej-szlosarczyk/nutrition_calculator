defmodule Person.Height do
  @moduledoc """
  Functions to perform height-related operations
  """

  alias Person.Height

  @type metric :: %{unit: :metric, meters: integer(), centimeters: integer()}
  @type imperial :: %{unit: :imperial, feet: integer(), inches: integer()}

  @inch 2.54
  @feet 12
  @meter 100

  defstruct unit: nil, value: nil
  @type t :: %Person.Height{
    unit: :metric | :imperial, value: number()
  }

  @doc """
  Assume metric system if no unit is given.
  """
  @spec create_height(number()) :: Height.t
  def create_height(value) when is_number(value) and value >= 0 do
    %Height{unit: :metric, value: value}
  end

  def create_height(_value) do
    raise(ArgumentError, message: "Value must be a positive number")
  end

  @spec create_height(number(), :metric | :imperial) :: Height.t
  def create_height(value, unit)
  when is_number(value) and value >= 0
  and (unit == :metric or unit == :imperial) do
    %Height{unit: unit, value: value}
  end

  def create_height(_value, _unit) do
    raise(ArgumentError, message: "Unknown or unsupported value type")
  end

  @spec convert_height(Height.t, :imperial) :: Height.t
  def convert_height(height = %Height{}, :imperial) do
    case height.unit do
      :imperial ->
        height
      :metric ->
        height.value
        |> (fn(x) -> x / @inch end).()
        |> Float.round(0)
        |> create_height(:imperial)
    end
  end

  @spec convert_height(Height.t, :metric) :: Weight.t
  def convert_height(height = %Height{}, :metric) do
    case height.unit do
      :metric ->
        height
      :imperial ->
        height.value
        |> (fn(x) -> x * @inch end).()
        |> Float.round(0)
        |> create_height(:metric)
    end
  end

  @spec decorate(Height) :: metric | imperial
  def decorate(height = %Height{}) do
    case height.unit do
      :imperial ->
        {feet, inches} = {Kernel.div(height.value, @feet),
                          Kernel.rem(height.value, @feet)}

        %{unit: :imperial, feet: feet, inches: inches}
      :metric ->
        {meters, centimeters} = {Kernel.div(height.value, @meter),
                                 Kernel.rem(height.value, @meter)}

        %{unit: :metric, meters: meters, centimeters: centimeters}
    end
  end
end
