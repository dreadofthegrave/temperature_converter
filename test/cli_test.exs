defmodule CliTest do
  use ExUnit.Case
  import TemperatureConverter.CLI, only: [parse_args: 1,
process: 1, to_fahrenheit: 1]

test "does c to f conversion works properly?" do
  assert to_fahrenheit("0") == 32.0
  assert to_fahrenheit("100") == 212.0
end

test "parse --help and -h flag returns atom :help" do
  assert parse_args(["-h", "anything"]) == :help
  assert parse_args(["--help", "bruuuh"]) == :help
  assert parse_args([5]) == [5]
end

test "processes list of temperatures" do
  assert process(["0", "100"]) == {:ok, [32.0, 212.0]}
  assert process(["-50", "-100"]) == {:ok, [-58.0, -148.0]}
end

end
