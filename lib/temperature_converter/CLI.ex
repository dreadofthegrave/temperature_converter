defmodule TemperatureConverter.CLI do

  @moduledoc """
  This module handles the parsing of the command line
  arguments as well as the output formatting.
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parsed = OptionParser.parse(argv, switches:
    [help: :boolean], aliases: [h: :help])
    case parsed do
      {[help: true], _, _} -> :help
      { _, list, _} -> list
#     _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: temperature_converter ["0", "14.2", "18.9", "19.1", "22.5", ...]
    """
    System.halt(0)
  end

  def process(list) do
    process_acc list, []
  end

  defp process_acc([], res) do
    {:ok, Enum.reverse res}
  end

  defp process_acc([h|t], res) do
    process_acc t, [h |> to_fahrenheit | res]
  end

  def to_fahrenheit(centigrade) do
    res = Float.parse(centigrade)
    case res do
      {float, _} -> float * 9/5 + 32
      _ -> 'NaN'
    end
  end

end
