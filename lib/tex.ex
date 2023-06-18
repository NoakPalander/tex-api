defmodule Tex.Core do
  require Logger

  @moduledoc false
  @settings %{
    "border" => 5,
    "size" => 100,
    "color" => "black",
    "background" => "white"
  }

  @template "priv/template.tex.eex"

  def process(string, args) do
    @template
    |> to_pdf!(string, Enum.map(args, &load_setting/1))
    |> to_png!()
  end

  defp load_setting({key, nil}), do: {key, Map.fetch!(@settings, to_string(key))}
  defp load_setting({key, val}), do: {key, val}

  defp to_pdf!(path, string, settings) do
    raw =
      path
      |> File.read!()
      |> EEx.eval_string([contents: string] ++ settings)
      |> Iona.source()
      |> Iona.to!(:pdf)

    Briefly.create!() |> tap(&File.write!(&1, raw, [:binary]))
  end

  defp to_png!(path) do
    "convert #{path} -flatten #{path}.png"
    |> String.split()
    |> Native.Task.async()
    |> then(fn {:ok, handle} -> Native.Task.await(handle) end)

    Logger.info(path)
    path <> ".png"
  end
end
